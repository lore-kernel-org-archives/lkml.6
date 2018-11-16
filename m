Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D759C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456602145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456602145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKPNOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:14:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeKPNOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:14:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A737C04959E;
        Fri, 16 Nov 2018 03:03:55 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89CAC5D6B3;
        Fri, 16 Nov 2018 03:03:54 +0000 (UTC)
Date:   Fri, 16 Nov 2018 11:03:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181116030351.GA18471@MiWiFi-R3L-srv>
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <20181027100241.GB1884@MiWiFi-R3L-srv>
 <CACi5LpPf9Zr1beowRNGmLZY7DtS3JDt8D=FONjqas9yo7TyCjg@mail.gmail.com>
 <20181030020752.GB11408@MiWiFi-R3L-srv>
 <CACi5LpP0_s9zAF+QfKpU+kG6BKqqkiwQhcW-WFZ0=SnBeX7ZXA@mail.gmail.com>
 <20181030085917.GC11408@MiWiFi-R3L-srv>
 <CACi5LpPrYgiy--FRgN4549cxLPMrtx6mY9_QRggKNo7gK3WxYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpPrYgiy--FRgN4549cxLPMrtx6mY9_QRggKNo7gK3WxYw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 16 Nov 2018 03:03:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 at 03:20am, Bhupesh Sharma wrote:
> I have sent a v2 patch with a much simpler git log message. Hopefully
> that should clarify the intent behind the patch.
> Also lets see what views the x86 maintainers have on the v2 patch.

Thanks, Bhupesh. That's great. Believe other people will help review and
give advice or ACK. I am busying on other issue and have no time to
review it for now. Thanks for the effort.

Thanks
Baoquan
