Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeDHCSv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:18:51 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:34690 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752068AbeDHCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:18:50 -0400
From: David Wang <davidwang@zhaoxin.com>
To: "'Borislav Petkov'" <bp@alien8.de>
CC: <tony.luck@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Bruce Chang (VAS)'" <BruceChang@via-alliance.com>,
        "'Cooper Yan(BJ-RD)'" <CooperYan@zhaoxin.com>,
        "'Qiyuan Wang(BJ-RD)'" <QiyuanWang@zhaoxin.com>,
        "'Benjamin Pan'" <BenjaminPan@viatech.com>,
        "'Luke Lin'" <LukeLin@viacpu.com>,
        "'Tim Guo(BJ-RD)'" <TimGuo@zhaoxin.com>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com> <1522403622-31146-2-git-send-email-davidwang@zhaoxin.com> <20180330102621.GA30063@pd.tnic> <0e48bb8d5dda4c8fbff849a052714524@zhaoxin.com> <20180404111822.GA16437@pd.tnic>
In-Reply-To: <20180404111822.GA16437@pd.tnic>
Subject: =?utf-8?Q?=E7=AD=94=E5=A4=8D:_=E7=AD=94=E5=A4=8D:_=5BPATCH_1/2=5D_x86/mce?=
        =?utf-8?Q?:_new_centaur_CPUs_support_MCE_b?=
        =?utf-8?Q?roadcasting?=
Date: Sun, 8 Apr 2018 10:18:05 +0800
Message-ID: <006001d3cedf$d44559e0$7cd00da0$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYmrVyn8DjGaOlaVUVJbKDnwnSCwIJVfHVAOI2Jb4CwpPPoAKcLQg1pCo3ZHA=
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----邮件原件-----
> 发件人: Borislav Petkov [mailto:bp@alien8.de]
> 发送时间: 2018年4月4日 19:18
> 收件人: David Wang <DavidWang@zhaoxin.com>
> 抄送: tony.luck@intel.com; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; linux-edac@vger.kernel.org;
> linux-kernel@vger.kernel.org; Bruce Chang (VAS)
> <BruceChang@via-alliance.com>; Cooper Yan(BJ-RD)
> <CooperYan@zhaoxin.com>; Qiyuan Wang(BJ-RD)
> <QiyuanWang@zhaoxin.com>; Benjamin Pan <BenjaminPan@viatech.com>;
> Luke Lin <LukeLin@viacpu.com>; Tim Guo(BJ-RD) <TimGuo@zhaoxin.com>
> 主题: Re: 答复: [PATCH 1/2] x86/mce: new centaur CPUs support MCE
> broadcasting
> 
> On Wed, Apr 04, 2018 at 02:34:52AM +0000, David Wang wrote:
> > Those are new processors and main usage of CentaurHauls CPUs in recent
> > years is for limited and/or embedded instead of distribution markets.
> > So there is no plan or resource to create such document for public
> > access. Is public spec mandatory for code check-in? We can provide
> > platforms for verification instead.
> 
> Nah, not needed. As long as the code paths don't break anything else and as
> long as we can CC you to fix bugs people report, we're good. :-)
> 
> Btw, please do not top-post on a public ML.

I got it.
Thanks.

---
David

> 
> Thx.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
