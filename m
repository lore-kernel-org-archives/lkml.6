Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78226C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C7C21773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfAIKsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfAIKsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:48:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC9A789ADB;
        Wed,  9 Jan 2019 10:48:07 +0000 (UTC)
Received: from ws.net.home (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04117600C3;
        Wed,  9 Jan 2019 10:48:06 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:48:04 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.33.1
Message-ID: <20190109104804.qeryw2xyp7j42mhc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1022-6b9065-dirty
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 10:48:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The util-linux stable release v2.33.1 is available at
                                        
  http://www.kernel.org/pub/linux/utils/util-linux/v2.33/
                                        
Feedback and bug reports, as always, are welcomed.
                                        
  Karel        


util-linux 2.33.1 Release Notes
===============================

agetty:
   - Return old behavior with empty logname  [Stanislav Brabec]
   - fix output of escaped characters  [Christian Hesse]
   - fix portability issues  [Samuel Thibault]
build-sys:
   - do not require crypt()  [Karel Zak]
   - do not require dirfd()  [Karel Zak]
   - make fdisk, sfdisk, cfdisk optional (enabled by default)  [Carlos Santos]
chmem:
   - add initilizer [clang]  [Sami Kerola]
choom:
   - fix negative adjust score usage  [Karel Zak]
dmesg:
   - correct "-n, --console-level level" example in manual page  [Jean-Philippe ROMAIN]
docs:
   - add link to mail list archive  [Sami Kerola]
   - update AUTHORS file  [Karel Zak]
fstrim:
   - Add Documentation key to fstrim.service  [Andreas Henriksson]
   - fix usage()  [Karel Zak]
include/c:
   - re-add type checking in container_of()  [Ruediger Meier]
libblkid:
   - (ntfs) fix compiler warning [-Wpedantic]  [Karel Zak]
   - fix detection of dm-integrity superblock  [Milan Broz]
   - stratis  correct byte order  [Tony Asleson]
libmount:
   - (umount) make mnt_stat_mountpoin() usable for relative paths  [Karel Zak]
libuuid:
   - fix man page typos  [Seth Girvan]
mkswap:
   - fix page size warning message  [Noel Cragg]
   - use dd(1) in example rather than fallocate(1)  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update sv.po (from translationproject.org)  [Sebastian Rasmussen]
setarch:
   - fix obscure sparc32bash use-case  [Karel Zak]
tests:
   - check for tar and {b,g}zip  [Karel Zak]
   - enlarge backing file for fstab-btrfs  [Karel Zak]
   - make lsns-netnsid portable  [Karel Zak]
   - run oids test only when uuidgen tool was built  [Thomas Deutschmann]
umount:
   - fix --quiet  [Karel Zak]
uuidd:
   - Add Documentation key to uuidd.service  [Andreas Henriksson]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
