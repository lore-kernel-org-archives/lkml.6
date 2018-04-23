Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1113844-1524485663-6-7417552907629634986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524485662; b=pES9/hhBtMkOilDbumv2fbZGaBUmHcuP64bbud6ZLB39BeGo+8
    1yCr04jW6aIHiml347fpfrr5l+ajJF2EGP/mPTCZH9n0Te+ubb9FjLtEmtyDB0OJ
    UjWprDiTUxILv7eTJf8t54XY3gfGBuhj7pR9c2W4COMibn8RZ2xhsI3qQHqSkUmv
    6TICersBp4NGpip/vrlYPDkKJvbGFPpTXXX8buXH0lK+bZ4XouS2Naw9lPfDRkeu
    9BTJeQXp3I8Wx/v7kdbzET40bgjh2JfTB6kJSuqOKCtfsXsftYOViQT2OukmtzsA
    CCU+GX5hsiw+awfQbTZ/kUfVCl9dtacp763A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524485662; bh=7A3Gv
    jcnY1LDuXKuz2ZY9QA3Tt2CK1sxWldmzIhsbN0=; b=flZBaJfBxImbod5H1uU8M
    eHh72Iyf52mlnGVoeTUptIuEfkUDXUszTKVV0aWwsXVOFCgM4t22B+UxRyy4NUKW
    9qKdCOO2gFXvw8Aykm9VxpQuc1GkE1Uh/82Gp9bV2HwRZkf8sf1gDiC14X46jjRN
    Xhk36cmK934EuNRT5u+5UgjRaz+mp497ZaodDq1t4ADsghO1Zzv9eShXlNNblzcJ
    zsj7Oxklv9xuywhhFHX4thx7r0ymcmgqjMTXPMcfNNuI2jhFecZZiRPmfmPJRsF/
    oI+wSZ11Se20Tqsy2TL+bu9evHAS6VHMPJDsyY9pnh/0atYdopF/hNHR8SymXguU
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLdhIbejt6gJXv5lxfgIySUrDjU4NUOo7h8SeWz0qNWqxgzmi4IoScQMKDN22PJ0H5GQJi97mAIeP3tFaPFV7NifPXGLcf63c6PoTNtNwOQw+hspObRf
    j3TYY0n4sjGmrrfjU8USJyB08qb62YYQBqPo8BvsiuD8lEoi2X+38ZvbmWJLqjVVUDgfTmEDIVgoGKQaQbkv7nAH4PmHL9FzQBycNKvK1Jck3GCsq77XgRxL
    JWDTkKF15XTPR/OnoVHM3A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=GFapNGFsAdMp78b4MBgA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 14:14:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 23/75] staging: ks7010: Remove unused 'struct rsn_t'.
Message-ID: <20180423121411.GB23835@kroah.com>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-23-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-23-quytelda@tamalin.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:08:03PM -0700, Quytelda Kahja wrote:
> 'struct rsn_t' is not used in this driver. Remove 'struct rsn_t'.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index a3c686c1289c..091bc82a99c4 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -231,11 +231,7 @@ struct ibss_parms {
>  	__le16 atim_window;
>  } __packed;
>  
> -struct rsn_t {
> -	u8 size;
>  #define RSN_BODY_SIZE 64

Also remove that.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
