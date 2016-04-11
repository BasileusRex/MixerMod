#!/sbin/sh
#
# /system/addon.d/55-mixer.sh
#
# Created by LUKEST85
#
# Before a ROM upgrade or dirty flash, this script will backup Device Audio Configuration files.
# After /system is formatted and reinstalled, then these files are restored.
# Before files are restored, this script will backup the new ROM /system files
#
# Thread: http://forum.xda-developers.com/<XDA-THREAD-LINK-ADDRESS>
#
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
addon.d/55-mixer.sh
etc/mixer_paths.xml
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    cp -pf etc/mixer_paths.xml etc/mixer_paths.xml.bak;
  ;;
  post-restore)
    # Stub
  ;;
esac
