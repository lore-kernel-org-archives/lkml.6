Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54130C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BC6208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BC6208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbeFRPyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:54:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753570AbeFRPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:54:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IFsAxh000700
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:54:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpe6qmjx9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:54:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 11:54:36 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 11:54:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IFsY7J7274782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 15:54:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE0AB205F;
        Mon, 18 Jun 2018 11:54:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C083CB2065;
        Mon, 18 Jun 2018 11:54:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 11:54:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9988916C6B0A; Mon, 18 Jun 2018 08:56:33 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:56:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix broken DMA vs. MMIO ordering example
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180617051608.2128-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617051608.2128-1-sj38.park@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061815-2213-0000-0000-000002BBAE22
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009214; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01048819; UDB=6.00537358; IPR=6.00827793;
 MB=3.00021721; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-18 15:54:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061815-2214-0000-0000-00005A864675
Message-Id: <20180618155633.GW3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 02:16:08PM +0900, SeongJae Park wrote:
> Translate this commit to Korean:
> 
>   5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Queued for review.  It would be good to get an ack from someone who
understood Korean, which is not me.  ;-)

							Thanx, Paul

> ---
>  Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index 921739d00f69..ada0a709cce1 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
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
> +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
> +     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
> +     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
> +     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
> +     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
> +     합니다.
> 
>       consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
>       문서를 참고하세요.
> -- 
> 2.13.0
> 

