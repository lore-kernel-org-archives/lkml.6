Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771586-1526394893-2-10171622764336772107
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526394892; b=UsqAl0yWkLf5JXhEJ//54mocsGdwZgmksFnhMdHOH9TEhbC82V
    PNBlJtgjQhbRiPAIrmTZQ9AEc4XdgF3TXv67wRg86fvPtIb2FFnLCjHBwPDBBkl7
    qYJlcS03J/nz029BWCH70DoQK+c0CPjqYcY6PgQ72SlDzJ6/tfX5a3kuwjXoNn8O
    mQk5a0+QKterGD6fw5K7uh9AMLKHwpoiVABpvYOYKEsdGB7G6PQsLyAEoGgwrt23
    /fIoxUliF5NSbxavkIazuJ3Uc8ZTNZh7E9+yasisCJ/dyudhgmXzc0HaGyjvOBbg
    KTqu4EehIsB2YjC1vrgizp8W4LVXUzAh/pXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526394892;
    bh=LCY4b+A6nfYbeuucwDb/bjq4Nv8mF7Cq4uIBo+6lnok=; b=XQy7ndJiIe4L
    sz7BioRcIlDNFz/R5pqap+s4iJvbRLDZ25qH6pqxP+/h0EFcnzaGZN9kOS9RR41s
    RzxdU+sUPtPaPZsNwMNPIhdBU2779isrqybZOtTjUj7LE2umt7xdN7RdgR+Dlg1P
    rrKJAEF3RFqkI1evyXrAi4OZPNiLUVKWtW0KUcbMXPcvCH1OdsW40qSh0oD28a7k
    MI2Lx656wQ/EpjpkrHprpry8uulg6MNfWgrigc9X8z4B1YoiAhXtcRPtaJ3T9M+3
    CyvchgYAyd7nbwj660KFuilc39vXTm6RQ9OzPA3/EIGndRag9FzMCgGJWLHhBZcs
    47o8EcTb2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=gMDXJ8/E x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=gMDXJ8/E x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwYFsfoSmsPA6zRbeApkG1DPK8oTO4DXjQtLweN6Flj6PP1NZCKofsRp6Gm5c02KtuxehGjc4QPU5jd3CgW4OntV2QpS41inrXTSaIPuKjuTY9MPq7+
    7RkpzD5T4iUTYuA+qbaKibBDbklWZLoCEJdovn45kVXtJKSB0+2RuOJW+XOBwWAKYhkrWh9yY4SMK8nHheppvjQe4ywdYs8NfO08cRrjdhd1v+LA39xpeeaK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=QP9oiXLwJZUBrUhRCQcA:9
    a=n0kzNNOx_tKw_JiW:21 a=TKVPlpMM1pJKbZ4_:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeEOOeu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 10:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbeEOOet (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 15 May 2018 10:34:49 -0400
Date: Tue, 15 May 2018 16:34:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: usbutils 010 release
Message-ID: <20180515143432.GA19432@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey, a new version of usbutils?  It's not October, what's happening?

Yes, I'm breaking with the "normal" slow release schedule of a new
usbutils release every year or so with a new release today.  The 010
release is now out at kernel.org and github.

There's been a number of new descriptors that are correctly parsed, many
thanks to Michael Drake for that.  Also, the biggest change, and the one
that drove this release, is the conversion of the lsusb.py script to
python3, allowing some distros to finally drop python2 from their list
of requirements.

Other than that, a number of small fixes and updates, and lots of
housekeeping (SPDX and copyright notices everywhere, the repo is now
'reuse lint' clean, and there is a SPDX bill-of-materials file.)

Full details of all changes are in the shortlog below.

The package can be downloaded from kernel.org:
        http://www.kernel.org/pub/linux/utils/usb/usbutils/

The source tree for usbutils can be found on both kernel.org and
github.com if you want to fork it and send us changes easier:
	http://git.kernel.org/?p=linux/kernel/git/gregkh/usbutils.git
	http://github.com/gregkh/usbutils/tree/master

thanks,

greg k-h

-----------

Aurelien Jarno (2):
      usbreset.c: add missing <stdlib.h> include
      Do not create and install usbutils.pc

Greg Kroah-Hartman (32):
      fix dump_videocontrol_interface for unitialized variable usage
      Add correct SPDX license identifiers to all files
      Add SPDX identifiers on files that did not have a specific license.
      wTotalLength should be printed as a hex number
      usbmisc: fix up some strncpy() issues
      lsusb-t: fix up error with readlink()
      lsusb.py.in: add proper SPDX license identifier
      usb-devices: reword the copyright identifier
      LICENSES: move the GPL 2 license to the LICENSES directory
      LICENSES/GPL-3.0.txt: add the file
      lsusb.h: add copyright notice
      lsusb-t: add copyright info
      bom.spdx: Add bill of materials file in SPDX format.
      ChangeLog: remove it.
      AUTHORS: remove file
      do_release: drop file
      NEWS: add SPDX header and comment
      autogen.sh: add SPDX and copyright header
      list.h: add copyright information
      travis-autogen.sh: add SPDX and copyright information.
      INSTALL: remove the file, it's boiler-plate
      configure.ac: add SPDX and copyright
      man pages: add SPDX and copyright information
      Makefile.am: add SPDX and copyright information
      .gitmodules: add SPDX and copyright lines
      lsusb.py.in: fix up Copyright strings
      usbreset.c: add Alan's copyright
      .travis.yml: add correct SPDX and copyright notices
      bom.spdx: update with latest copyright and SPDX identifier additions
      README.md: move the README file to markdown
      README.md: fix fomatting
      bom.spdx: upate with README -> README.md change

Lukas Nykryn (1):
      lsusb.py: convert to python3

Michael Drake (11):
      lsusb: Split subtype mapping out of AudioControl interface handling.
      lsusb: Add declarative definitions for UAC1 and UAC2 descriptors.
      lsusb: Add code to dump descriptor data using descriptor definition.
      lsusb: Switch to descriptor-definition based dump for UAC1 and UAC2.
      lsusb: Add descriptor definitions for UAC3.
      lsusb: Add initial support for USB Audio Device Class 3.
      lsusb: Add descriptor definition for USB3 BOS Configuration Summary.
      lsusb: Dump USB3 BOS Configuration Summary Descriptor.
      lsusb: Squash Wpointer-compare warning.
      lsusb: Remove unused function.
      lsusb: Fix array entry count for variable sized entries.

Robby Workman (1):
      Makefile.am: Include usbreset.c in the release tarball

Torleiv Sundre (1):
      lsusb: Dump UVC Stream based payload descriptor.

