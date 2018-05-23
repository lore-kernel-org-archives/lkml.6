Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeEWFtZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbeEWFtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:49:22 -0400
Date: Wed, 23 May 2018 08:49:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, xavier.huwei@tom.com, lijun_nudt@163.com
Subject: Re: [PATCH rdma-next 3/5] RDMA/hns: Increase checking CMQ status
 timeout value
Message-ID: <20180523054918.GB2933@mtr-leonro.mtl.com>
References: <1526544173-106587-1-git-send-email-xavier.huwei@huawei.com>
 <1526544173-106587-4-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <1526544173-106587-4-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2018 at 04:02:51PM +0800, Wei Hu (Xavier) wrote:
> This patch increases checking CMQ status timeout value and
> uses the same value with NIC driver to avoid deficiency of
> time.
>
> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index 182b672..f16df1b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -76,7 +76,7 @@
>  #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
>  #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
>  #define HNS_ROCE_INVALID_LKEY			0x100
> -#define HNS_ROCE_CMQ_TX_TIMEOUT			200
> +#define HNS_ROCE_CMQ_TX_TIMEOUT			30000

Don't you think that loop of 30 seconds too much?

Thanks

>
>  #define HNS_ROCE_CONTEXT_HOP_NUM		1
>  #define HNS_ROCE_MTT_HOP_NUM			1
> --
> 1.9.1
>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbBQDeAAoJEORje4g2clintsUQAJcvwgqpEgKrAVIxgFaidJRv
eDjfyHnwXsDwS0wDe+57XdQQVJkGVHRUgb3fvGr69BLgIjgaO0zlj0SXJF9w8azc
sySVeUOMh5Uios85PCgu5/ukgk0x8kJnTvC1i53f9D63nsgaVrO2ahpTr228qymZ
XxG6yvlAZ+uqSbzmtHLCnyLnAA1wItifhKgby+Z8Ahw1InHq+puz/SfU1GEPo+iE
c7ClnXt71O1IB/D8XY+uvmhtPHS63U+suLuwciijAF5Q0z53X4CzRF09yYsn0Ynh
xWDaCBNbeZW1xB1Yr9Fm6OqTIsjBYxqTGXgD2UNYF1/VJ6FmF5CBdDohFnzyI2b5
yfT/E0iKL77z0HBnRhHCPoEXJcJ/7IdwRwyLMnNhJ5mrS4juBpKwBTtnsiJtjKM4
W6E2lULN6wM6tejaB2T3XrIZpHg0Q/Dn+Beur4BEwM5tgrs5crIxaNB5V0DitIOj
4u3F33t9ZurR3g9iGKPeM5osxMDnsXpGtqRokwgF1MPZ3CVOPG57w1tJhKwmamKx
ufhWjuqTFf/0HPqpxrF0Xla8M3/HQD95qcfGe23NjnB1PGmxnzHrR8mzyljnOdYL
zdJQy26FXlz/bmGGlptEc/Sb0jPBUitNaaZGBLC6SwYL2/lyz84hNdycaZtPUAMr
WCpbUCfpwU49IP1TvTlx
=0aCv
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
