Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2747092-1518870533-2-1771218312815931802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518870532; b=VXGpvSZfWty45q2AYhy30aS2q6BSu9EwaExy58dIYSXMKVr
    i7PEFIyKJ7nICEAGonlc5cNmyAZX8ZrTh5HFvVg0tMpv5CAKDGzm9EH36U46B2ev
    7oP5yRPXmoYZQXBkBMbYw3Q7vx2EiBv66TscbcwROkr2EMhWtFhlsv82FsqEQNID
    VaPSycop86QwHpFzS8qFKvr4xONyT+4+s59YWt1Zi5RDlOcUij/VxXbv8J5s+EJP
    vMQ87JX4r9QdLy23vaE4micToUjIcG0KhNHSEKV6dCroxkEcgclusN28LtMwJHwU
    WCSAqFh4MeQT+1UJJKdGphA4SipZTiYq+aBYjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518870532; bh=+
    943sPA16GCEhpMSGsrb8RU/y73cvB9k4AvwGmZOELc=; b=m2U3CwhIKP4O5UIAf
    N9VPtVqLTduDbqTBrNaCJPY19El2oMIw5NKEl8kDCXV0vP4NIHTlwsPA9+mw2S6Y
    WeeCmalISqEo1yZBBqJv8mHfDVfdq94JKhGwieHVroLGvsSNu+V5uRaegXmYNxDj
    G+ZB0bZeyl441Fp6QQyRoBZviZpoZk90AXvxoyZf7FxmbcfaOP1oTzS5WYfX+hbk
    OsL9GomZVQd8uh24KAkiV8H+5EJ8U1on3ttc1vQcrp+BUuLysAhg3OBBiXnR5nmT
    zknVdPcKkj8tOCuyzQR8cviuzR0wo2Qx85gm7wnt9spkkgr/0caXpf0e1VQOA1wY
    0L7NQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 17 Feb 2018 12:53:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yash Omer <yashomer0007@gmail.com>
Subject: Re: [PATCH] Staging: ks7010: fix unnecessary parentheses in
 ks_hostif.c
Message-ID: <20180217115342.GB9433@kroah.com>
References: <20180217095645.22946-1-yashomer0007@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180217095645.22946-1-yashomer0007@gmail.com>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 03:26:45PM +0530, Yash Omer wrote:
> This patch fixes up unncessary parentheses warning found by checkpatch.pl script
> 
> Signed-off-by: Yash Omer<yashomer0007@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 7bd567e233d7..36055652842d 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -36,7 +36,7 @@ inline u8 get_BYTE(struct ks_wlan_private *priv)
>  {
>  	u8 data;
>  
> -	data = *(priv->rxp)++;
> +	data = *priv->rxp++;

Oh that's a mess, please just leave the original () there, otherwise you
have to really remember what order comes first here.  The () gives the
reader a huge hint as to what is being incremented.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
