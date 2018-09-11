Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16060C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC362086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC362086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIKLTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:19:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:19:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6LCtU2135809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:21:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6LCc52135806;
        Mon, 10 Sep 2018 23:21:12 -0700
Date:   Mon, 10 Sep 2018 23:21:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-07e846bace717729fd20b5d99521a5f8c7d7a9cb@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, jason.wessel@windriver.com,
        rdunlap@infradead.org, tglx@linutronix.de, yinghai@kernel.org
Reply-To: tglx@linutronix.de, rdunlap@infradead.org, yinghai@kernel.org,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          ebiederm@xmission.com, jason.wessel@windriver.com
In-Reply-To: <d0c40ac3-7659-6374-dbda-23d3d2577f30@infradead.org>
References: <d0c40ac3-7659-6374-dbda-23d3d2577f30@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/doc: Fix Documentation/x86/earlyprintk.txt
Git-Commit-ID: 07e846bace717729fd20b5d99521a5f8c7d7a9cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  07e846bace717729fd20b5d99521a5f8c7d7a9cb
Gitweb:     https://git.kernel.org/tip/07e846bace717729fd20b5d99521a5f8c7d7a9cb
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sun, 5 Aug 2018 20:34:05 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 15:09:30 +0200

x86/doc: Fix Documentation/x86/earlyprintk.txt

Fix a few issues in Documentation/x86/earlyprintk.txt:

- correct typos, punctuation, missing word, wrong word
- change product name from Netchip to NetChip
- expand where to add "earlyprintk=dbg"

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Link: http://lkml.kernel.org/r/d0c40ac3-7659-6374-dbda-23d3d2577f30@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/earlyprintk.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.txt
index 688e3eeed21d..46933e06c972 100644
--- a/Documentation/x86/earlyprintk.txt
+++ b/Documentation/x86/earlyprintk.txt
@@ -35,25 +35,25 @@ and two USB cables, connected like this:
 ( If your system does not list a debug port capability then you probably
   won't be able to use the USB debug key. )
 
- b.) You also need a Netchip USB debug cable/key:
+ b.) You also need a NetChip USB debug cable/key:
 
         http://www.plxtech.com/products/NET2000/NET20DC/default.asp
 
-     This is a small blue plastic connector with two USB connections,
+     This is a small blue plastic connector with two USB connections;
      it draws power from its USB connections.
 
  c.) You need a second client/console system with a high speed USB 2.0
      port.
 
- d.) The Netchip device must be plugged directly into the physical
+ d.) The NetChip device must be plugged directly into the physical
      debug port on the "host/target" system.  You cannot use a USB hub in
      between the physical debug port and the "host/target" system.
 
      The EHCI debug controller is bound to a specific physical USB
-     port and the Netchip device will only work as an early printk
+     port and the NetChip device will only work as an early printk
      device in this port.  The EHCI host controllers are electrically
      wired such that the EHCI debug controller is hooked up to the
-     first physical and there is no way to change this via software.
+     first physical port and there is no way to change this via software.
      You can find the physical port through experimentation by trying
      each physical port on the system and rebooting.  Or you can try
      and use lsusb or look at the kernel info messages emitted by the
@@ -65,9 +65,9 @@ and two USB cables, connected like this:
      to the hardware vendor, because there is no reason not to wire
      this port into one of the physically accessible ports.
 
- e.) It is also important to note, that many versions of the Netchip
+ e.) It is also important to note, that many versions of the NetChip
      device require the "client/console" system to be plugged into the
-     right and side of the device (with the product logo facing up and
+     right hand side of the device (with the product logo facing up and
      readable left to right).  The reason being is that the 5 volt
      power supply is taken from only one side of the device and it
      must be the side that does not get rebooted.
@@ -81,13 +81,18 @@ and two USB cables, connected like this:
       CONFIG_EARLY_PRINTK_DBGP=y
 
     And you need to add the boot command line: "earlyprintk=dbgp".
+
     (If you are using Grub, append it to the 'kernel' line in
-     /etc/grub.conf)
+     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
+     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
+     using Grub2 on an EFI firmware system, append it to the 'linux'
+     or 'linuxefi' line in /boot/grub2/grub.cfg or
+     /boot/efi/EFI/<distro>/grub.cfg.)
 
     On systems with more than one EHCI debug controller you must
     specify the correct EHCI debug controller number.  The ordering
     comes from the PCI bus enumeration of the EHCI controllers.  The
-    default with no number argument is "0" the first EHCI debug
+    default with no number argument is "0" or the first EHCI debug
     controller.  To use the second EHCI debug controller, you would
     use the command line: "earlyprintk=dbgp1"
 
@@ -111,7 +116,7 @@ and two USB cables, connected like this:
     see the raw output.
 
  c.) On Nvidia Southbridge based systems: the kernel will try to probe
-     and find out which port has debug device connected.
+     and find out which port has a debug device connected.
 
 3. Testing that it works fine:
 
