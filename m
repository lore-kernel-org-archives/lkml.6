Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7ACC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF70921722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF70921722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeKLQ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:28:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54781 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbeKLQ2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:28:51 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAC6aWGX3556589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 11 Nov 2018 22:36:33 -0800
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Li Zhijian <zhijianx.li@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
References: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
 <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
 <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
 <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
 <20181112045624.GA28219@gmail.com>
 <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
 <20181112061940.GA61749@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <766e1f84-b8c0-db95-45d3-e624c8d61519@zytor.com>
Date:   Sun, 11 Nov 2018 22:36:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112061940.GA61749@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 10:19 PM, Ingo Molnar wrote:
> 
> I might be a bit dense early in the morning, but could you elaborate? 
> What do you mean by mapping all data areas?
> 

Heh. I need to pack for LPC and get some sleep before my flight lest I'll be
denser than depleted uranium; I'll write an explanation tomorrow.

	-hpa

