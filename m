Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE732C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3607522BF3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3607522BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeFZG6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:58:39 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:34761 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeFZG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:58:37 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 26 Jun 2018 15:58:35 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 26 Jun 2018 15:58:35 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 26 Jun 2018 15:58:27 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@linux.vnet.ibm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix broken DMA vs. MMIO ordering example
Message-ID: <20180626065827.GC20783@X58A-UD3R>
References: <20180617051608.2128-1-sj38.park@gmail.com>
 <20180626004738.GA20783@X58A-UD3R>
 <alpine.DEB.2.20.1806261218490.1528@hxeon>
 <20180626045609.GB20783@X58A-UD3R>
 <alpine.DEB.2.20.1806261406220.1528@hxeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1806261406220.1528@hxeon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:10:17PM +0900, SeongJae Park wrote:
> 
> 
> On Tue, 26 Jun 2018, Byungchul Park wrote:
> 
> > On Tue, Jun 26, 2018 at 12:21:23PM +0900, sjpark wrote:
> > > Hello Byungchul,
> > >
> > >
> > > On Tue, 26 Jun 2018, Byungchul Park wrote:
> > >
> > > > On Sun, Jun 17, 2018 at 02:16:08PM +0900, SeongJae Park wrote:
> > > > > Translate this commit to Korean:
> > > > >
> > > > >   5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> > > >
> > > > Hi SeongJae,
> > > >
> > > > You keep doing good jobs ;)
> > > >
> > > > I believe it would be better if you consider the little things below
> > > > more. What do you think about it, SeongJae?
> > >
> > > Thank you for great comments!
> > >
> > > >
> > > > > Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> > > > > ---
> > > > >  Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
> > > > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> > > > > index 921739d00f69..ada0a709cce1 100644
> > > > > --- a/Documentation/translations/ko_KR/memory-barriers.txt
> > > > > +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> > > > > @@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
> > > > >  		/* 소유권을 수정 */
> > > > >  		desc->status = DEVICE_OWN;
> > > > >
> > > > > -		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
> > > > > -		wmb();
> > > > > -
> > > > >  		/* 업데이트된 디스크립터의 디바이스에 공지 */
> > > > >  		writel(DESC_NOTIFY, doorbell);
> > > > >  	}
> > > > >
> > > > >       dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
> > > > > -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > > > > -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
> > > > > -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
> > > > > -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
> > > > > -     보장해주기 위해 필요합니다.
> > > > > +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > > > > +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
> > > >                                                                         ^
> > > >                                                                      참고로,
> > >
> > > Nice comment.  This will enhance the readability a lot.
> >
> > Could you add this, too? A quite little thing tho.
> 
> Oops, I missed that.  Sorry.  Attaching the patch below.
> 
> 
> Thanks, SeongJae Park

Thanks a lot, SeongJae.

Acked-by: Byungchul Park <byungchul.park@lge.com>

> ============================= >8 =====================================
> 
> >From bcfb52af5d1f6c6aa171d105bdd7376b4dfabf13 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj38.park@gmail.com>
> Date: Sun, 17 Jun 2018 14:08:42 +0900
> Subject: [PATCH v3] locking/memory-barriers.txt/kokr: Update Korean
>  translation to fix broken DMA vs. MMIO ordering example
> 
> Translate this commit to Korean:
> 
>   5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> ---
> Changes since v1:
>  - Applied comments from Byungchul Park
>  - Rebased on v4.18-rc2
> 
>  .../translations/ko_KR/memory-barriers.txt         | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index 921739d00f69..7f01fb1c1084 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -1891,22 +1891,22 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
>  		/* 소유권을 수정 */
>  		desc->status = DEVICE_OWN;
> 
> -		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
> -		wmb();
> -
>  		/* 업데이트된 디스크립터의 디바이스에 공지 */
>  		writel(DESC_NOTIFY, doorbell);
>  	}
> 
>       dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
> -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
> -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
> -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
> -     보장해주기 위해 필요합니다.
> -
> -     consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
> -     문서를 참고하세요.
> +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  참고로,
> +     writel() 을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory)
> +     쓰기가 MMIO 영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에
> +     wmb() 를 실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이
> +     저렴한 writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지
> +     않아야 합니다.
> +
> +     writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
> +     "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
> +     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
> 
> 
>  MMIO 쓰기 배리어
> -- 
> 2.13.0
> 
> 
> >
> > > > > +     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
> > > > > +     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
> > > > > +     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
> > > > > +     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
> > > > > +     합니다.
> > > > >
> > > > >       consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
> > > > >       문서를 참고하세요.
> > > >
> > > >      See the subsection "Kernel I/O barrier effects" for more information on
> > > >      relaxed I/O accessors and the Documentation/DMA-API.txt file for more
> > > >      information on consistent memory.
> > > >
> > > > Don't you think the whole sentence need to be translated? If yes, then
> > > > it would be better to do that as well ;)
> > >
> > > Oh, my mistake!  It should be.
> > >
> > > I applied your comments to the second version.
> >
> > Thank you SeongJae :)
> >
> > > Thanks,
> > > SeongJae Park
> > >
> > > >
> > > > > --
> > > > > 2.13.0
> > > >
> > > > --
> > > > Thanks,
> > > > Byungchul
> > > >
> >
> >

