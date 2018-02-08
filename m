Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518099500; cv=none;
        d=google.com; s=arc-20160816;
        b=t5rlkE+wMoFvtZKKx70lBNhhPElSnfUHz8NTRqtAP16w4jtxSoN+qCK1TtgxdYEprQ
         VcaMyl/9HEqJ1ycWUIVZ5BVXbVIDgpLlsv/FN05MxhAykGYaYuX403RnlHrPO9its5We
         ZYkrDJvMzuLJ6udVem0yz2jQ1oVGrC0HYwy5JHYekbwmbLbI8ZKYGuEZcZK5DLW0CGfI
         qhsGW0gbZPnlt3b3GhXY7FjezS7FO5FleBc5VgywcDcRhCn5ZEC+DwohOo+gzDRC2U3Z
         OCbwYAtrKYYGT6jyM130VYnW8FhiE7kWaLVvqqbXqnpQ2b8OvECcW9riXoicuWgFBCHh
         7n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QOMa1Ot4PRWX0iN0ZsxA3ghiRr4K7Q5iH40XS7F4sPk=;
        b=E2dfE8x67k/fzJBcto+OSuGNkmWoTXwHn4fiWzpBUXCDcenqObF8hCwsjEUhDwpFVS
         KggLNzFwpCpKJzgy4netQAsC8OBvWvAaEu60q/sOHdLjofuzBx+TjZo3xHNTqqaTAEuk
         pQ+uK5tKliLV56VPdbLClly5wIxv++4MT6fFP7d3VsfGpI4bWfxjkbyEv3ZTX7RXWJ/z
         A4N81TuTZhNT6J5J4HYygygwQ4Ht5w6iIyPZODTDQbmczYJCGFr1glRC3F+PJSnodGlu
         DKetIGrmB+Tcmdj6bhqyxyAA3kaS3is3DltYFTGPBHIFzGIzjX1k4nW1F0zr6Tys6FSv
         bXOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=VmN5I3NK;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=VmN5I3NK;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x226S1TDefJK9JqRFp7dLY6Y2cK1CQ0ebNp9zK9UIfS9Y+gj7fjecUWM2+Q2PXJIvuR9y8cftkym5O7QzpVh5ebY=
MIME-Version: 1.0
In-Reply-To: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:17:39 +0100
Message-ID: <CAOFm3uHagzL5r5MYfu1ep5nf9Y6RAj866+uUO74c1mJRYPfeQg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add SPDX tag for s390_pci_hpc.c
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590975893239641061?=
X-GMAIL-MSGID: =?utf-8?q?1591842701897469187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Bjorn,

On Tue, Jan 30, 2018 at 1:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> I previously posted patches [1] to add SPDX tags to all drivers/pci files
> except drivers/pci/hotplug/s390_pci_hpc.c.  I omitted that one because it
> contained only a "License: GPL" comment, which I thought was ambiguous.
>
> However, I think it is actually unambiguous because the file was added with
> a 'MODULE_LICENSE("GPL")', and include/linux/module.h shows that means "GPL
> v2 or later".
>
> So this patch adds the GPL-2.0+ tag to the file.  I plan to include this
> for v4.16 unless somebody objects.

As I as said in a previous email, context matters a lot in these case
and you made the right choice.
When there is a MODULE_LICENSE and a super terse "GPL" license notice,
the two taken together can provide the proper context e.g. here
GPL-2.0+ rather than a less common GPL-1.0+

Thank you for your efforts there!

-- 
Cordially
Philippe Ombredanne
