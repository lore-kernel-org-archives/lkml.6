Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-560798-1519059944-2-6738942642709592367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519059943; b=KSjuimcfa4rqhJ+AAgErmMorosLZstLecLNaX4wzyNLmOqM
    anZQhU3h5XnZ9uS1CWJKFNbtrb6qRKKZ0CQtWem85tg6Q5mTttIbSxz6c1dUt9z8
    Z5u+zAqDDwSSAp1XctVVgEExvRPJwO9QGAOpHJPDZLK1W1EsPleQZjEuBQmt1Awj
    ACTJGzf9Mfh0VqZudCl8FHawqiYR1GsPqn5E0scP6mPoDqzf2T913rDKeHy4Xphy
    vleTsnju2XwWW4AE+RhqUZPz1+vfoscHYPiveYpwy7iexVGqT/Sz1YKWlmo0HQXM
    nnkMv2dQ0ajeFLjdkJKeRqELXlax5ctnViG4nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519059943; bh=/
    y0+YFnh4wu/eXII4dUPwpOCvlcpoA85NnHLJLOdn04=; b=EfyXBVdehP/qqCmTw
    spJRNc1AO2YS4X5wQLQdG5jAhpPGBAjy5oFJ0TgSd+o8SPLDp8oRmu8xcV0Gvyc4
    zyXs8QY3x+huX54ebyqjoyuMFA8ucYzUdfPT1udW8sZ+bTtwJUNCoGpLapsbLxpZ
    bRYGpUn7AVCKcH5RYtrbChDIYB5RF49adcp+RJw9BzMZLlkAV5CalSpb8Sgl0j1J
    lHzdmINvsevGvLebWqUmdZzQ6fVyOx+fmIVuSvRz4m/g3xF0j3oIMXhTnE/FoBPP
    Yvhr3jfqAhRmvOqA0928WSV8JMZKMcuem+/ybbw6MBCReTGXQY3NGfj8wqpSkDfJ
    U4Quw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Feb 2018 18:05:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] Staging: gdm724x: LTE: Fix trailing open parenthesis
 code style issue.
Message-ID: <20180219170538.GB18723@kroah.com>
References: <20180216214008.17105-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180216214008.17105-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 01:40:08PM -0800, Quytelda Kahja wrote:
> Fix a coding style problem causing warnings from checkpatch.pl.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/gdm724x/gdm_lte.c | 50 ++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
> index 0527b0d1c1d0..ff3fed9c4a81 100644
> --- a/drivers/staging/gdm724x/gdm_lte.c
> +++ b/drivers/staging/gdm724x/gdm_lte.c
> @@ -204,9 +204,12 @@ static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
>  	pseudo_header.ph.ph_nxt = ipv6->nexthdr;
>  
>  	w = (u16 *)&pseudo_header;
> -	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++)
> -		sum = csum_add(sum, csum_unfold(
> -					(__force __sum16)pseudo_header.pa[i]));
> +	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++) {
> +		__wsum tmp_sum;
> +
> +		tmp_sum = csum_unfold((__force __sum16)pseudo_header.pa[i]);
> +		sum = csum_add(sum, tmp_sum);
> +	}
>  
>  	w = ptr;
>  	while (len > 1) {
> @@ -510,18 +513,18 @@ static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
>  {
>  	struct nic *nic = netdev_priv(dev);
>  	struct hci_packet *hci = (struct hci_packet *)buf;
> +	struct gdm_endian *phy_endian;
>  	int idx;
> +	u16 cpu;
>  	int ret;
>  
>  	ret = sscanf(dev->name, "lte%d", &idx);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	return netlink_send(lte_event.sock, idx, 0, buf,
> -			    gdm_dev16_to_cpu(
> -				    nic->phy_dev->get_endian(
> -					    nic->phy_dev->priv_dev), hci->len)
> -			    + HCI_HEADER_SIZE);
> +	phy_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
> +	cpu = gdm_dev16_to_cpu(phy_endian, hci->len);
> +	return netlink_send(lte_event.sock, idx, 0, buf, cpu + HCI_HEADER_SIZE);
>  }
>  
>  static void gdm_lte_event_rcv(struct net_device *dev, u16 type,
> @@ -728,17 +731,21 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
>  {
>  	struct nic *nic = netdev_priv(dev);
>  	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
> +	struct gdm_endian *dft_endian;
> +	struct gdm_endian *nic_endian;
>  
>  	if (pdn_table->activate) {
>  		nic->pdn_table.activate = pdn_table->activate;
> -		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(
> -						nic->phy_dev->get_endian(
> -							nic->phy_dev->priv_dev),
> -						pdn_table->dft_eps_id);
> -		nic->pdn_table.nic_type = gdm_dev32_to_cpu(
> -						nic->phy_dev->get_endian(
> -							nic->phy_dev->priv_dev),
> -						pdn_table->nic_type);
> +
> +		dft_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
> +		nic_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);

These are the same values :(

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
