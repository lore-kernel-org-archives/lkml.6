Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE22520B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE22520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeGPMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:05:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729910AbeGPMF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7737A4000B74;
        Mon, 16 Jul 2018 11:38:53 +0000 (UTC)
Received: from ws.net.home (ovpn-117-177.ams2.redhat.com [10.36.117.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADBD42156893;
        Mon, 16 Jul 2018 11:38:52 +0000 (UTC)
Date:   Mon, 16 Jul 2018 13:38:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.32.1
Message-ID: <20180716113850.g6t7l2fvuml3eh6k@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170912-66-504cd9
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 16 Jul 2018 11:38:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 16 Jul 2018 11:38:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kzak@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The util-linux stable release v2.32.1 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.32

Feedback and bug reports, as always, are welcomed.

  Karel


util-linux 2.32.1 Release Notes
===============================

agetty:
   - keep c_iflags unmodified on --autologin  [Karel Zak]
blkid:
   - (man) add note about udev encoding  [Karel Zak]
blkzone:
   - fix whole device detection  [Karel Zak]
build-sys:
   - extend "Could not locate the pkg-config" error message  [Karel Zak]
   - improve bison version detection  [Karel Zak]
cfdisk:
   - fix compiler warnings, follow-up 7085f1e4 (#636)  [Ruediger Meier]
   - fix missing prototype for `get_wch`  [Patrick Steinhardt]
   - use uint64_t to avoid compiler warnings  [Karel Zak]
chcpu:
   - Fix maximal number of CPUs  [Stanislav Brabec]
column:
   - fix leading space characters bug  [Karel Zak]
dmesg:
   - fix raw output  [Karel Zak]
   - link together with syslog(2) manual page  [Sami Kerola]
docs:
   - update AUTHORS file  [Karel Zak]
exec_shell:
   - prevent ".  applet not found" error when SHELL env is not set.  [osexp2000]
fdisk:
   - fix compiler warning [-Wmaybe-uninitialized]  [Karel Zak]
fstrim:
   - Return EXIT_FAILURE when FTRIM ioctl fails  [Karel Zak]
   - cleanup includes  [Karel Zak]
lib/strutils:
   - fix strnlen() fallback  [Karel Zak]
libblkid:
   - (hfs) check allocation size  [Karel Zak]
   - (ntfs) enlarge cluster limit to 2MB  [Karel Zak, Jean-Pierre André]
   - (ntfs) fix cluster size check  [Karel Zak]
   - (zfs) fix compiler warning [-Wmaybe-uninitialized]  [Karel Zak]
   - udf  Fix reporting UDF 2.60 revision  [Pali Rohár]
libfdisk:
   - (docs) fix section name  [Karel Zak]
   - fix compiler warning [-Wunused-parameter]  [Karel Zak]
   - fix list_del after partition reset  [Vaclav Dolezal]
   - use \x<hex> to read/write partition name  [Karel Zak]
libmount:
   - fix compiler warning [-Wunused-parameter]  [Karel Zak]
   - fix mnt_table_is_fs_mounted() for NFS bind mounts.  [NeilBrown]
   - improve docs about mnt_context_mount() return codes  [Karel Zak]
   - include sys/mount.h on Linux only  [Karel Zak]
   - include sys/mount.h only if necessary  [Karel Zak]
   - fix possible segfault during umount -a  [Richard Fuchs]
libsmartcols:
   - don't print empty column  [Karel Zak]
logger:
   - Define SD_JOURNAL_SUPPRESS_LOCATION.  [YmrDtnJu]
lsblk:
   - don't exclude RAM disks on --all  [Karel Zak]
   - fix notes about RAM disks  [Karel Zak]
lscpu, chcpu:
   - Avoid use of the old CPU macros  [Stanislav Brabec]
lslocks:
   - add info about OFD  [Karel Zak]
   - fix memory leak  [Karel Zak]
lslogins:
   - fix password verification  [Karel Zak]
partx:
   - exit with error code when partition read failed  [Andreas Henriksson]
po:
   - fix lsblk translation  [Karel Zak]
   - merge changes  [Karel Zak]
   - pt_BR  fix fallocate '-l' help msg  [Luiz Angelo Daros de Luca]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
rename:
   - consolidate printing the symlink in addition to its target  [G.raud Meyer]
   - fix/reverse the semantics of --no-overwrite in --symlink mode  [G.raud Meyer]
rfkill:
   - include <poll.h> instead of <sys/poll.h>  [Patrick Steinhardt]
setarch:
   - add another PER_LINUX32 aliases for ppcle  [Karel Zak]
tests:
   - update column(1) space-separator test  [Karel Zak]
umount:
   - add note about --lazy  [Karel Zak]
zramctl:
   - (man) explain that --find is necessary  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
