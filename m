Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F72177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbfBRQ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:56:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46091 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbfBRQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:56:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id i5so10319079qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=FR5YgBqnbU1sKoRWEfj6850DTW3GqcOpetPCtjylHa4=;
        b=lmX5o2qiPF+A+UviYcMCBwSBGUUqL8tyoxNssJN1c//UqeF/6L0cSPYzXeLeBMpSS9
         bGgRJw/DbpIJp2+n9a0S5nj+w8fnFG+Ne6tgPShS25Pc97msTK020tDr5sZaVynCp6Hj
         daJDKREzgfx4OqSAwV2s6sAUbalylec/lZRn5c93Ddljjs54YBO2fdxhsE8m2aelk7Qt
         1lCxe/7AhL5t/BBPtz9zQfDxwX8KX7j1rGXsusEcX9KXCXSPp26/0TdB5nHAreFeSBc6
         lBONL10xxR2kTd4ueTUvbDMTeFBFS45uuVU2aE4wvWe8x+ILxnfuWwG8EuR2RJKQDBg+
         k9mQ==
X-Gm-Message-State: AHQUAuZ5T8GvXx5GRH7NOlXDqK5WU8I/76ppC207Q1lE3ES2J4PvYDyd
        xab1YDjOMj7XvuEXtKcPzONgcs8VNdmyFg==
X-Google-Smtp-Source: AHgI3IZKV6IhKIIhb10b9C7mu4mM00I+/gl6EmIwibwm8P/ZdQ2JhzMKKkJw15vtIp7YlBfkFBsklg==
X-Received: by 2002:ae9:ed0c:: with SMTP id c12mr16649602qkg.306.1550508970059;
        Mon, 18 Feb 2019 08:56:10 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id p186sm7259687qkb.69.2019.02.18.08.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:56:09 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:56:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Fwd: Invitation to comment on Virtual I/O Device (VIRTIO) Version
 1.1 - ends February 21st
Message-ID: <20190218115145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For everyone's information, pls see below.

Unfortunately earlier attempts to forward this announcement got blocked
by the spm filter. Sorry about that.  There are still a couple of days
left to comment though.

----- Forwarded message from Paul Knight <paul.knight@oasis-open.org> -----

Date: Mon, 11 Feb 2019 00:01:28 -0500
From: Paul Knight <paul.knight@oasis-open.org>
To: tc-announce@lists.oasis-open.org, members@lists.oasis-open.org, OASIS TAB <tab@lists.oasis-open.org>,
	virtio-email@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Subject: [virtio-comment] Invitation to comment on Virtual I/O Device (VIRTIO) Version 1.1 - ends February 21st
Message-ID: <CADgeAH9MH8sJpuzmNidBsxf7-8CqnQteXVTSgPNcsrY9W9xg+w@mail.gmail.com>

OASIS members and other interested parties,

OASIS and the OASIS Virtual I/O Device (VIRTIO) TC are pleased to announce
that Virtual I/O Device (VIRTIO) Version 1.1 is now available for public
review and comment.

Specification Overview:

This document describes the specifications of the “virtio” family of
devices. These  devices are found in virtual environments, yet by design
they look like physical devices to the guest within the virtual machine -
and this document treats them as such. This similarity allows the guest to
use standard drivers and discovery mechanisms. The purpose of virtio and
this specification is that virtual environments and guests should have a
straightforward, efficient, standard and extensible mechanism for virtual
devices, rather than boutique per-environment or per-OS mechanisms.

The documents and related files are available here:

Virtual I/O Device (VIRTIO) Version 1.1
Committee Specification Draft 01 / Public Review Draft 01
20 December 2018

Editable source (Authoritative):
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/tex/
HTML:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
PDF:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.pdf

Example driver listing:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/listings/

For your convenience, OASIS provides a complete package of the
specification document and any related files in ZIP distribution files. You
can download the ZIP file at:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.zip

How to Provide Feedback

OASIS and the OASIS Virtual I/O Device (VIRTIO) TC value your feedback. We
solicit input from developers, users and others, whether OASIS members or
not, for the sake of improving the interoperability and quality of its
technical work.

The public review starts 23 January 2019 at 00:00 UTC and ends 21 February
2019 at 23:59 UTC.

Comments may be submitted to the TC by any person through the use of the
OASIS TC Comment Facility which can be used by following the instructions
on the TC's "Send A Comment" page (
https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio).

Comments submitted by TC non-members for this work and for other work of
this TC are publicly archived and can be viewed at:

https://lists.oasis-open.org/archives/virtio-comment/

All comments submitted to OASIS are subject to the OASIS Feedback License,
which ensures that the feedback you provide carries the same obligations at
least as the obligations of the TC members. In connection with this public
review, we call your attention to the OASIS IPR Policy [1] applicable
especially [2] to the work of this technical committee. All members of the
TC should be familiar with this document, which may create obligations
regarding the disclosure and availability of a member's patent, copyright,
trademark and license rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose these if
they may be essential to the implementation of the above specification, so
that notice of them may be posted to the notice page for this TC's work.

Additional information about the specification and the VIRTIO TC can be
found at the TC's public home page:
https://www.oasis-open.org/committees/virtio/

========== Additional references:

[1] https://www.oasis-open.org/policies-guidelines/ipr

[2] https://www.oasis-open.org/committees/virtio/ipr.php
https://www.oasis-open.org/policies-guidelines/ipr#Non-Assertion-Mode
Non-Assertion Mode
-- 
Paul Knight <paul.knight@oasis-open.org>  - Tel: +1 781-883-1783
OASIS <https://www.oasis-open.org/> - Advancing open standards for the
information society - Document Process Analyst
<https://www.oasis-open.org/people/staff/paul-knight>

----- End forwarded message -----
