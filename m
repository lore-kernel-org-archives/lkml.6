Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2323227-1525764143-2-5777502438850684973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525764142; b=MM5t1Q5HmyHTRfPBnYJ4vo1I9ScY2W45Lfeo8abhD87q5Hbfb2
    WM4FaN7aFuO2I8i1OCl6+Cf9pAwI0xQ9sxs3F2fr9QGVPAJyrB36ff4/Veox92D9
    UwcnBVWVymXjdFG09qX1yNSvkNFwQyxO5MwtqLU2l8ZBnGiyZXuPF/88dVFbwqCu
    FJPpKcdjGEq5gKlkEaXMCex3DGBaOdlqQlOmIS/fsqTTi0yPS6rCIIrmQ59RUUgo
    X/jDZ9l+6qFoTV7WbBrclRadRCb9Lu1PSo0zh+Ct05fgY3GW2vzk/FOZ6roSciu6
    BMsYrxLZaxWYWXQz9PS0ag18uJVWem1fzHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525764142; bh=Q0hmJ
    Y8T1ikabtMzYm3tDu9g0qfdIpb2YNU/44r6gkk=; b=Mamus5hiex+kBo5sEMKD/
    Axm/zkLBsF0eEQGInW5OfnK6Z6/SlYXZz0M3cyJlYc3v3ISjKweNHnJK44L1WUG3
    +06gemzjUF1ee6d1iE+0/YAGw2CdGoMtljTc3PpemjRPcksCSs1bNOrTfn/4GYdl
    zBe3LOcQz0KZS0qxpS2L0pgqc3u64FGPsVtQQxRbZkU+aOfvqnmx6lhCbRiF01m8
    2wtYhyNjXNrV2JESVsgNg3cBYyKZSXq2aahw823XfFY63Yco/3DmsN6Hypylk2R8
    UHJ1HEUrbpX/pKcT5GYxBg9dHW44eg8rj+S+L+SnV8CsLPdKuv5SuS4oiHPp+1D2
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIwJ1qmuNfBl1AUNPh2XXLRBCNYyN5Va1k+/SKLyck1iVu/EECjW0ru/T7w4fWWNP/44Q+QXenwgt5TfidQrgj5SfEp1tvK8gVY0OERsCpk/bH4i39s4
    KoFtI8W+4PFGo9tqo4Ltfk8msbhO+LbWIwsYyYqaYKnKFX0cubA05v08T9xocB18q2xPiXt/0PliC1KpUXFPn4n91Onvb4z5w+6kZxvIx4TxgW+mshLKyQrG
    dN579WBLQSwnLv+/7COFuQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=HAZ7V5VAKuDbAxE40uYA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,377,1520924400"; d="scan'208";a="52419556"
Date: Tue, 8 May 2018 15:18:51 +0800
From: Yunliang Ding <yunliang.ding@intel.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] media: atomisp: fix spelling mistake: "diregard" ->
 "disregard"
Message-ID: <20180508071850.GA17320@intel.com>
References: <20180429120647.10194-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180429120647.10194-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, Alan Cox <alan@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-29 at 13:06:47 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in ia_css_print message text

Hi Colin,

The atomisp drivers will soon EOL accorinding to the ML discussion.

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../css2400/css_2401_csi2p_system/host/csi_rx_private.h         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h b/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
> index 9c0cb4a63862..4fa74e7a96e6 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
> +++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/css_2401_csi2p_system/host/csi_rx_private.h
> @@ -202,7 +202,7 @@ static inline void csi_rx_be_ctrl_dump_state(
>  		ia_css_print("CSI RX BE STATE Controller %d PEC ID %d custom pec 0x%x \n", ID, i, state->pec[i]);
>  	}
>  #endif
> -	ia_css_print("CSI RX BE STATE Controller %d Global LUT diregard reg 0x%x \n", ID, state->global_lut_disregard_reg);
> +	ia_css_print("CSI RX BE STATE Controller %d Global LUT disregard reg 0x%x \n", ID, state->global_lut_disregard_reg);
>  	ia_css_print("CSI RX BE STATE Controller %d packet stall reg 0x%x \n", ID, state->packet_status_stall);
>  	/*
>  	 * Get the values of the register-set per
> -- 
> 2.17.0
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
