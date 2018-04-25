Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672703-2-5911669489464010616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672701; b=GeMmqO09D8c5NAP4ZsrxNt7IeCKf0Qzt7sWIL1mcnZHydLfirs
    i6bG2fbEYutRlf9/KvTs+9vRO5UQOAHVbsbqTPdk9bbUuVsa7xO6lV6kpcj8QLMP
    v+379jYdzzedkqVGYL94OIT2AIUy+VC5zIj+ZUnkv9QCI25E/24DLVfrcg9s6JsT
    0fxZD/n4ySNdFhfpjEPgqvqjJpNl4+Md94f2SQCXhznJ/urVk6Ta+/KB4I2Sv31z
    WQyzavxCuLh888P4LkN5Y40C3repo6j2+R0b9Geh3NKEPVVmz8W3/SUI0apX9rLb
    iq6HX9btIGmuEn/5w0NWQZM8hXh3hGKqzLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524672701; bh=z70DP
    +BH2X6OpdZM8YJ7+zQYdvt/oqb+WtSyakygn4E=; b=XegKFqQEsdwDag0zBeeJh
    AaQQHAlh25HKevqhzBtD+RAPLmlpHqtFgHaLzLmnJag8/ddeKq+zApwwe92MApkD
    cHVBbO10qUZ1wTdX3t957Py8urn7yav8SVVDSUqmw8GmfhJJWAEUND0FnCx1tW9y
    nF8eBPX5nzreCd7Pmeaft/IvrjZr00yIJgv7HyPDARMfT2dTqhcZ6Ann67elPKKl
    9YC+jXt6iObQMXVFt9g+vm6OZESX96R28Zckd4x/2X/BEX1xE9637RF3y8gCL8iD
    L2MeaRGnyqcXJihT5GVzWv3hVwR0f0nxC5gRQynslU8JtIAPYXaKwTWK8nHVMR5G
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF7TLVi6wVjJ1V3IGpRvgqkgfIrVgq0TwlTl64dL7svbHznHtpvMWjhCUiMmwKK3TxUNKySPqvYeRb1e8lK3txkKFOdRYiV1ELNxIL4oom4HveH8wEZv
    U7xrij6bgQ78gvDIXXYpovA7WrnGIae956qXVYy6pHVcfPzfmq5zy1oKz7PD50bJi/Bzf0QcYY53cSENGq6JFGCfBtgPWmLsDi6tUBqINpp9u0iqY/wybLWq
    hxnowLVEmQeFc5+FSyQTuQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=jp5uUZKRKvbujw_BeY4A:9 a=5l0zR64t4fAwKJi3:21 a=0tmGfeLXjvakv-Yz:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400"; d="scan'208";a="14212586"
Subject: Re: [PATCH] staging/wilc1000: fix wilc_mac_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 <linux-kernel@vger.kernel.org>
References: <20180424131857.5668-1-luc.vanoostenryck@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <3c4bbd52-5af9-72b9-732b-f83f0bd23905@microchip.com>
Date: Wed, 25 Apr 2018 18:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131857.5668-1-luc.vanoostenryck@gmail.com>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Aditya Shankar <aditya.shankar@microchip.com>, linux-wireless@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Luc,

I'm resending this since last time I only send it to staging ml.

Could you, please, change the "return 0;"s inside wilc_mac_xmit() with
"return NETDEV_TX_OK" ?

Thank you,
Claudiu

On 24.04.2018 15:18, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/staging/wilc1000/linux_wlan.c | 2 +-
>  drivers/staging/wilc1000/wilc_wlan.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
> index 38a83bd31..e06aaed5e 100644
> --- a/drivers/staging/wilc1000/linux_wlan.c
> +++ b/drivers/staging/wilc1000/linux_wlan.c
> @@ -941,7 +941,7 @@ static void linux_wlan_tx_complete(void *priv, int status)
>  	kfree(pv_data);
>  }
>  
> -int wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
> +netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct wilc_vif *vif;
>  	struct tx_complete_data *tx_data = NULL;
> diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc1000/wilc_wlan.h
> index fa157a67b..d3b5a6b38 100644
> --- a/drivers/staging/wilc1000/wilc_wlan.h
> +++ b/drivers/staging/wilc1000/wilc_wlan.h
> @@ -298,7 +298,7 @@ void wilc_chip_sleep_manually(struct wilc *wilc);
>  
>  void wilc_enable_tcp_ack_filter(bool value);
>  int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
> -int wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
> +netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
>  
>  void WILC_WFI_p2p_rx(struct net_device *dev, u8 *buff, u32 size);
>  void host_wakeup_notify(struct wilc *wilc);
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
