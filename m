Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440419-1525563414-2-16502561927151063673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525563413; b=FyjpkZPU38l0yF/Yabo63BRba4948YB1kx5IMLhQlTHAt8UD9/
    X/rqZ/3/0341WisPn0LsoZiXLN/flfm3cKpFaIE931jOPUDUsaWGSHfuf3bQSz16
    rlyF/7rzkqVl9Zhd1SE1wgcFtuc/U8Pl1ogUP/i0A1QK/f7tbCOjKky5k7vpWZAZ
    TDKp5zReAuvcT3zi3yBklCSauL7848DHVmnVLeaIKkRXXGKYKNGTmZvQQujfprgS
    3x8FcyYefzg1D8TXiujzhW1z9YX/Ho56O6yT5MPyxx+Ndk9r02XXcqJjuWIiOkXF
    mXfecR+GdJvwM6AmvZ8FDm6tUVHTL+mnhQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525563413; bh=dy9XrEs6r8yz9HsXHEP1r716+zdy3O
    oEok+3SakvMPY=; b=DxZ23VhUdbWbo4zDPh1tg0aR9IEh4smaVB09LQX/UskYK/
    +87yqcS+e1/Hyb3KmD59eoXw28SuA1Xgzlvh1E8cmsNKdT/iiF4IyiykHUt+HlN7
    V04UZHTA1HZ4HKtGDIZwG1aaqLkIOsTyATuK03/ErF/5mXgj950pK8jjX3TIE8iw
    uCVe4phg5oXzFo3zrb2c5GwjosHWHqMvzwsaYa6Bw1hVfRsnEQwqRXsf/qsoKSLi
    mPDS9CeY8tBGMFsSn0hzY+du7jDDyJaFwKSgZE//zFs/ZH/tmgh43bmdQ64HRI+U
    R2ovmrrh1GKMxDJ8tQ8hDWGXkGfZ+Ns1U4qAbH7Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=sRq3O6rv x-bits=1024
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=sRq3O6rv x-bits=1024
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMzmXlz0QLy64CFtWzsxhMeq+jMx0Q/8lU7jDyKDe+apEyElqkvLnxFIc4xD2AFTKP5V4Oxfq9v4p7QIiDMZmHh6TL+0gzw+EmgFrVcjzI/s/iUUaO0x
    EyRazFdGiJ1d8lYzGay2fWZs3SLewkixDMSjk7OpWYdj1jDnO5Qakoaiv4mpQl2fi9Km4TjCL8/o3110/0gZ7p5Mv3runYkoT1gjiXGt4pkQjDWaZj+09F/2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=CKLiFELGjDaRwdwv00AA:9 a=QEXdDO2ut3YA:10
    a=l_KOVhCsiiEA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeEEXgk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 5 May 2018 19:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEEXgj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 5 May 2018 19:36:39 -0400
Date: Sat, 5 May 2018 16:36:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.17-rc4
Message-ID: <20180505233627.GA14556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.17-rc4

for you to fetch changes up to 6844dc42722cac37762a45e742ab4b2cc5348023:

  Merge tag 'usb-serial-4.17-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2018-05-04 14:38:32 -0700)

----------------------------------------------------------------
USB fixes for 4.17-rc4

Here are some USB driver fixes for 4.17-rc4.

The majority of them are some USB gadget fixes that missed my last pull
request.  The "largest" patch in here is a fix for the old visor driver
that syzbot found 6 months or so ago and I finally remembered to fix it.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Artur Petrosyan (1):
      usb: dwc2: WA for Full speed ISOC IN in DDMA mode.

Bin Liu (2):
      usb: musb: host: fix potential NULL pointer dereference
      usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Greg Kroah-Hartman (4):
      Merge tag 'fixes-for-v4.17-rc3' of git://git.kernel.org/.../balbi/usb into usb-linus
      USB: serial: visor: handle potential invalid device configuration
      Revert "usb: host: ehci: Use dma_pool_zalloc()"
      Merge tag 'usb-serial-4.17-rc4' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Heikki Krogerus (2):
      usb: typec: tcpm: Release the role mux when exiting
      usb: typec: tps6598x: handle block reads separately with plain-I2C adapters

Joel Pepper (1):
      usb: gadget: composite Allow for larger configuration descriptors

Luc Van Oostenryck (1):
      usb: gadget: f_phonet: fix pn_net_xmit()'s return type

Mathias Nyman (1):
      xhci: Fix use-after-free in xhci_free_virt_device

Mayank Rana (1):
      usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

SZ Lin (林上智) (1):
      USB: serial: option: adding support for ublox R410M

Tomeu Vizoso (1):
      usb: dwc2: dwc2_vbus_supply_init: fix error check

Wei Yongjun (2):
      usb: dwc2: pci: Fix error return code in dwc2_pci_probe()
      usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static

 drivers/usb/core/config.c              |  4 +-
 drivers/usb/dwc2/core.h                |  2 +
 drivers/usb/dwc2/gadget.c              | 21 +++++++++++
 drivers/usb/dwc2/hcd.c                 | 13 ++++---
 drivers/usb/dwc2/pci.c                 |  4 +-
 drivers/usb/dwc3/gadget.c              |  4 +-
 drivers/usb/gadget/function/f_phonet.c |  2 +-
 drivers/usb/host/ehci-mem.c            |  3 +-
 drivers/usb/host/ehci-sched.c          |  6 ++-
 drivers/usb/host/xhci.c                |  1 +
 drivers/usb/musb/musb_gadget.c         |  3 +-
 drivers/usb/musb/musb_host.c           |  4 +-
 drivers/usb/serial/option.c            |  5 +++
 drivers/usb/serial/visor.c             | 69 +++++++++++++++++-----------------
 drivers/usb/typec/tcpm.c               |  1 +
 drivers/usb/typec/tps6598x.c           | 47 +++++++++++++++++++----
 include/linux/usb/composite.h          |  2 +-
 17 files changed, 133 insertions(+), 58 deletions(-)
