Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754850AbeEHJEP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:04:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55158 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeEHJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:04:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180508090410euoutp01a4a40f724bbb559e10ba768efca60a0d~sn-Vqbh6y0857908579euoutp01k
X-AuditID: cbfec7f2-1dbff70000011644-8d-5af16808cd46
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Frank Mori Hess <fmh6jj@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
Date: Tue, 8 May 2018 11:04:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2484918.HKVQc3yJkt@bear>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87ocGR+jDPacFrbYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzeLuv0+MFjvvnGB24PDYOesuu8eRncfYPBbvecnksWlV
        J5tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZXw8dIe54IxoxZ75F1gaGK8LdjFyckgImEg8
        uX2PuYuRi0NIYAWjxMOmzcwgCSGBL4wS6zYUQCQ+M0r8XNzNCtNx5u5yNojEckaJsy0dTBDO
        e0aJ7tdzWECqhAVsJdq3nGIDsUUEkiQ+fL3AAlLELHAYqGjlDrAiNgFDia63XUBFHBy8AnYS
        R5fwgoRZBFQkrvzawARiiwrESEybdx3M5hUQlDg58wlYK6eAmsTEI+/A4swC8hLb385hhrDF
        JW49mQ92kITAMXaJD7cvQJ3tInH2+A82CFtY4tXxLewQtozE/53zmSDseom+70egmnsYJfa2
        TIVKWEscPn6RFeRQZgFNifW79EFMCaAnf25IhTD5JG68FYQ4gU9i0rbpzBBhXomONiGIGWoS
        s46vg1t68MIl5gmMyrOQPDYLyTOzkDwzC2HtAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ
        +bmbGIFJ6fS/4592MH69lHSIUYCDUYmH90fBhygh1sSy4srcQ4wSHMxKIrzKsh+jhHhTEiur
        Uovy44tKc1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhj78g2mFTo0b3CZcupe
        1wL7vd/fHUp6M/Pg0Q96pbeXbZBcp/GSNWy5zuQdNyb42PorcfwSP7pp6qnrDlqfHgtPOKiz
        0WVNVGr80twze5Nefv8SFOL9X1XBdAXPrLrEZzLT3irauDPZNBzin9jVqSixfEXIL0Y/y945
        16Pezk5+4j5nhTNXZb6nEktxRqKhFnNRcSIAUIGAqUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7rsGR+jDDZ85LbYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzeLuv0+MFjvvnGB24PDYOesuu8eRncfYPBbvecnksWlV
        J5tH35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk
        5mSWpRbp2yXoZXw8dIe54IxoxZ75F1gaGK8LdjFyckgImEicubucrYuRi0NIYCmjxIrd61kh
        EjISJ6c1QNnCEn+udUEVvWWU+HDmPSNIQljAVqJ9yyk2EFtEIEmi5+MlVpAiZoHDjBKndnUz
        gSSEBFQlXt94zQ5iswkYSnS9BZnEwcErYCdxdAkvSJhFQEXiyq8NYOWiAjESP452sYDYvAKC
        EidnPgGzOQXUJCYeeQdWwyxgJjFv80NmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJyywkLbOQ
        tCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGInbjv3csoOx613wIUYBDkYlHt4fBR+i
        hFgTy4orcw8xSnAwK4nwKst+jBLiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGCSyCuJNzQ1
        NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwLhM+dkvlu5F755OWX/9VoKf
        /lLtI9xL2e7uNLheeWD5LJ7MZ1nzNvpHBDWGnDq1xHlHgt6vpjf9MVNuTik/KHypRWiTqQpT
        bMKjaXsVvGZPvyN5IFlNRzO1eO7/Qpfw8wfLz12yFA5jfRsgP/XyhR8ekvMMHxZPqNs822/G
        vivrOBeXbV9yeuZpJZbijERDLeai4kQA/osRGtoCAAA=
X-CMS-MailID: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
X-RootMTR: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
References: <2484918.HKVQc3yJkt@bear>
        <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank and Vinod,

On 2018-04-28 23:50, Frank Mori Hess wrote:
> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
>
> The pl330.c pause implementation violates the dmaengine requirement
> for no data loss, since it relies on the DMAKILL
> instruction.  However, DMAKILL discards in-flight data from the
> dma controller's fifo.  This is documented in the dma-330 manual
> and I have observed it with hardware doing device-to-memory burst
> transfers.  The discarded data may or may not show up in the
> residue count, depending on timing (resulting in data corruption
> effectively).
>
> Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>

This revert completely breaks serial driver operation on almost all Exynos
SoCs, because serial driver relies on having PAUSE feature and proper
residue reporting from dma engine. Please drop it if possible.

> ---
>   drivers/dma/pl330.c | 28 ----------------------------
>   1 file changed, 28 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 6237069001c4..f802bd3b0481 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2290,33 +2290,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
>   	return 0;
>   }
>   
> -/*
> - * We don't support DMA_RESUME command because of hardware
> - * limitations, so after pausing the channel we cannot restore
> - * it to active state. We have to terminate channel and setup
> - * DMA transfer again. This pause feature was implemented to
> - * allow safely read residue before channel termination.
> - */
> -static int pl330_pause(struct dma_chan *chan)
> -{
> -	struct dma_pl330_chan *pch = to_pchan(chan);
> -	struct pl330_dmac *pl330 = pch->dmac;
> -	unsigned long flags;
> -
> -	pm_runtime_get_sync(pl330->ddma.dev);
> -	spin_lock_irqsave(&pch->lock, flags);
> -
> -	spin_lock(&pl330->lock);
> -	_stop(pch->thread);
> -	spin_unlock(&pl330->lock);
> -
> -	spin_unlock_irqrestore(&pch->lock, flags);
> -	pm_runtime_mark_last_busy(pl330->ddma.dev);
> -	pm_runtime_put_autosuspend(pl330->ddma.dev);
> -
> -	return 0;
> -}
> -
>   static void pl330_free_chan_resources(struct dma_chan *chan)
>   {
>   	struct dma_pl330_chan *pch = to_pchan(chan);
> @@ -3027,7 +3000,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>   	pd->device_tx_status = pl330_tx_status;
>   	pd->device_prep_slave_sg = pl330_prep_slave_sg;
>   	pd->device_config = pl330_config;
> -	pd->device_pause = pl330_pause;
>   	pd->device_terminate_all = pl330_terminate_all;
>   	pd->device_issue_pending = pl330_issue_pending;
>   	pd->src_addr_widths = PL330_DMA_BUSWIDTHS;
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
