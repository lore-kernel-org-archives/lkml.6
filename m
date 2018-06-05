Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFEKy7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:54:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751820AbeFEKyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:54:55 -0400
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Wang YanQing <udknight@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH v5] block: add verifier for cmdline partition
Thread-Topic: [PATCH v5] block: add verifier for cmdline partition
Thread-Index: AQHT6Av4OP23kM1HY0i+PmOza2mCRqRRC8QAgACahkA=
Date: Tue, 5 Jun 2018 10:54:45 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B794419@dggemm511-mbx.china.huawei.com>
References: <20180510030637.GA25734@udknight>
 <20180605093840.GA9488@udknight>
In-Reply-To: <20180605093840.GA9488@udknight>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.217.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACK.

the patch is OK for me

> -----Original Message-----
> From: Wang YanQing [mailto:udknight@gmail.com]
> Sent: Tuesday, June 05, 2018 5:39 PM
> To: axboe@kernel.dk; gregkh@linuxfoundation.org;
> pombredanne@nexb.com; tglx@linutronix.de; Caizhiyong
> <caizhiyong@hisilicon.com>; rdunlap@infradead.org; Jiangheng
> <jiangheng@hisilicon.com>; linux-block@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5] block: add verifier for cmdline partition
> 
> On Thu, May 10, 2018 at 11:06:37AM +0800, Wang YanQing wrote:
> > I meet strange filesystem corruption issue recently, the reason
> > is there are overlaps partitions in cmdline partition argument.
> >
> > This patch add verifier for cmdline partition, then if there are
> > overlaps partitions, cmdline_partition will log a warning. We don't
> > treat overlaps partition as a error:
> > "
> > Caizhiyong <caizhiyong@hisilicon.com> said:
> > Partition overlap was intentionally designed in this cmdline partition.
> > reference http://lists.infradead.org/pipermail/linux-mtd/2013-
> August/048092.html
> > "
> >
> > Signed-off-by: Wang YanQing <udknight@gmail.com>
> > ---
> >  Changes
> >  v4-v5:
> >  1:Delete unnecessary blank line at begin and end of logs.
> >  2:Delete newline character in log, pr_* will add newline
> >    automatically.
> >
> >  v3-v4:
> >  1:Fix grammar typo, reported by Randy Dunlap.
> >  2:Delete unnecessary type casting, reported by Caizhiyong.
> >  3:Record the reason why we can't treat overlapping partitions
> >    as errors into changelog.
> >
> >  v2-v3:
> >  1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
> >  2:Fix out of bound access in cmdline_parts_verifier.
> >
> >  v1-v2:
> >  1:Don't treat overlaps partition as a error, but log a warning.
> >
> >  Hi! Jens Axboe
> >
> >  What is your suggestion?
> Hi! All
> 
> I just want to know what is the status about this patch?
> 
> ACK or NACK is welcome.
> 
> Thanks
