Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F81C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA002145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfBEG32 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:29:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59583 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEG32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:29:28 -0500
Received: from [IPv6:2601:646:8680:2bb1:3934:ee17:def4:e8a2] ([IPv6:2601:646:8680:2bb1:3934:ee17:def4:e8a2])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x156R0Am735641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 4 Feb 2019 22:27:02 -0800
Date:   Mon, 04 Feb 2019 22:26:48 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrWupURU3QW-hs238oCwK0kUV+dpv4NWmH4E9=DBurrMpg@mail.gmail.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <CALCETrWupURU3QW-hs238oCwK0kUV+dpv4NWmH4E9=DBurrMpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v5 00/13] x86: Enable FSGSBASE instructions
To:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <BC66FCE7-D338-4A2A-AB70-3D33D486FE20@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 1, 2019 6:43:25 PM PST, Andy Lutomirski <luto@kernel.org> wrote:
>Hi hpa-
>
>A while back, you were working on some patches to make modify_ldt()
>play better with this series.  What happened to them?
>
>--Andy

Looks like I need to dig them out...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
