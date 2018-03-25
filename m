Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2133390-1521977927-2-10877834825249907367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521977926; b=sWKDg0Kh6bqY9fGq40vTMp4tsmVl+J22flLhtNbxkYj5PWM
    RLUS7K0SQdXJWTdkczVIuxUDV0Uk7vD+eHc9qDcxujiYFjLWpTeGU/MskdRusYW1
    O2/QoUrzPpFQMv4LBkxk2nXc+al9gjlotl3ZBBEAv+xNlluO1DKHTEXyIcYFfbBj
    hUNM+hOs9qG06gXGLvkl5RmZIKyEmiIXzDSytSP4l5h/HV0nbEQ567w1L/hpO/93
    OBHDMWSkXQLMhIAKM2e7SsSeIeo7q75zQnGXLIUeEKGfQB55CKlxLRiyg3wjYHa8
    WWhwL7m9H8hie9URfRc2CR06ICzCmK1WrDSx91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521977926; bh=4
    8nBttE7fh/y4SXS3Fx+eJeav30ZT254GyUbgYbsDHA=; b=HkDKjm6QKj0YCKQ6q
    +9O6TEyuiUwAse67xD5qNYGG7vxkxkPdBlgNmdlgdiXH62pOZiVmxPlYz9kvXNRj
    xp6Sx1r7EO6l5NpIROgrED9o33tYtv1Cx6wnmz/goVbhmDtXcSl9jh9GH3K7NOS5
    7eaP7trMYwmHEn9g8tCYJCIPL+1Y/eo1bK1wwRdpgHVnMz+rn6cDnFrNV7p+6JL0
    r4AzqTC8y0Odu3gCiFaF7TxGAVDn/X90Ti6cX13ER1u97BQIw/44IgjuvM67bfK2
    QWRR1UEvmBTjYl+TIEmdlMxU0xlhDx/0OVuZNyV+CkysmGTJPCV/bogCCqQtFLoi
    +xFwg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 25 Mar 2018 13:38:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next][V2] staging: r8822be: fix typos in header guard
 macros
Message-ID: <20180325113837.GA28090@kroah.com>
References: <20180323180018.21737-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180323180018.21737-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 06:00:18PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The macros for __PHYDMKFREE_H__ and __PHYDM_FEATURES_H__ contain
> typos and don't match the #if guard check. Defined them correctly.
> 
> Cleans up clang warnings:
> warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> warning: '__PHYDM_FEATURES_H__' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> 
> Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtlwifi/phydm/phydm_features.h | 2 +-
>  drivers/staging/rtlwifi/phydm/phydm_kfree.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_features.h b/drivers/staging/rtlwifi/phydm/phydm_features.h
> index 37f6f0cd7235..a12361c6a1a0 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_features.h
> +++ b/drivers/staging/rtlwifi/phydm/phydm_features.h
> @@ -24,7 +24,7 @@
>   *****************************************************************************/
>  
>  #ifndef __PHYDM_FEATURES_H__
> -#define __PHYDM_FEATURES
> +#define __PHYDM_FEATURES_H__
>  
>  /*phydm debyg report & tools*/
>  
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> index 1ee60059afc1..2c6b0a48e76e 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> +++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> @@ -24,7 +24,7 @@
>   *****************************************************************************/
>  
>  #ifndef __PHYDMKFREE_H__
> -#define __PHYDKFREE_H__
> +#define __PHYDKKFREE_H__

Close, but not quite :(

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
