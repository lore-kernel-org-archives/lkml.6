Return-Path: <outreachy-kernel+bncBCUJ7YGL3QFBB4MH7LKAKGQETHR6F7I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520337906; cv=pass;
        d=google.com; s=arc-20160816;
        b=VOtNTij5XgaT24N7NyxTGoc9xE20T1MnQ+CfDPyXGyL4hvLgUkt24VTSZTiHCuLEA/
         6h4TteUUdpfB/3onXS4y0XyZH27Yx8qlPF5DnhWY20LvZLsF2GUja8a4zof1xXmXNofK
         Sq0zXegrUs9MmAojZHZVbx8b1jQzuyTNN7lOZpQG5mj+lSqlQZO1n8gf04sE6yt7SvBo
         S0p9o0YPJ+PgQvyJRXSALxt7xpI9ND3aHmrfnl5Gjb9kM7Mh0zubaaPyKvO5uXqx+vqk
         RZ/YseKfYrE3t6xSg3Zh6ras/MuCj1+Lr5Z+D8q4p10Fw/8pzIBomJXPQg7Fd0Rx4pw/
         LECA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=i05hBX5OH0WEzPVpOqoVx6Dcb65+dkbyC9n4MXM4bEs=;
        b=F1T7lnYXQ6fIqosX3nU2MGQdsLCD9shvaGqwJ0eeEa47Su4nlmNMwvuiM7OCegwEvd
         IK+VmlF5ngT/LfRtZuGxcf9rmQ9a/dlLeVgZ9xKcRj3dqUVtCustZ6OynyeQ5sofI/9X
         GY28n/ulnLt9CWgclxRxZpwNm5R8je+fJ4RW2gon9YCTOY9rppcJF4HYjKBcB6K0P6xk
         ZhV2cbiV4z1rZK5VUaVs0twggOmBqs+bCMfjg5a2kwnhVBcZH8vfahviv2cFIpr/mblq
         4hymMpsM7uCVwQR/UXO023rSEnxSmeBkeb5r4vz8r4CFU8u615Vss1f0+yCfx+kMgbWt
         W9Rw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=dCbV7C5Z;
       arc=pass (i=2 spf=pass spfdomain=linuxfoundation.org);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuj7ygl3qfbb4mh7lkakgqethr6f7i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUJ7YGL3QFBB4MH7LKAKGQETHR6F7I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=dCbV7C5Z;
       arc=pass (i=2 spf=pass spfdomain=linuxfoundation.org);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuj7ygl3qfbb4mh7lkakgqethr6f7i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUJ7YGL3QFBB4MH7LKAKGQETHR6F7I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520337905; cv=pass;
        d=google.com; s=arc-20160816;
        b=palGLuhYWU5PAhh/Bs/mpWWtDGfHv2P4LW2SHn4wsLFnTlUJlJuOz261Wy3mRgVGXR
         BwCHTt7Trjm53Bcjyx9HGvZjizx1knG7kUmygOrpIJSPiM6qnVBRARQdsbjGV/8+szqZ
         1yL5LetocOsahy1E2ZBe8G0RpVEXLOspj1MggSDcReyrMPihVfIkOmOsXc1tOy04DHhW
         DtqOPGdJXE1pF0vW2jsxEcQoL7V6mkWPc3nrZmwSiVDGnsvbrEthKRylDBLJOvWfo44z
         vTlVWnMPRSXdiQiwhbDdChXvlaNsZHStxw7ybz1WxxW2sjRQLtQs1JaaNf5NGZw4cuao
         1WIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=i05hBX5OH0WEzPVpOqoVx6Dcb65+dkbyC9n4MXM4bEs=;
        b=JNFDHH74CeVoTZqkzh3Hgwxd5mR6gED/yitQ3pKC1NNT54YaJ1DHbX4wmHsVY4tk6G
         vQhsw33JZ6Oo2cihUHMDPyCp6Eye+grSXvL6OEk28OVYp7Z+C0y93av31hg/yIHy+q9e
         UZggAsWanGv8eQ8tknbSyxQfXmi4xzpi/BMz2NEc0LFfihMYBEe9unvC0XKjd9Y1XDGX
         AEj9yepaO6jn0kFG+u2GM+D3zKgfQkOM3oUnAKBuMg3+jRpH2kCj3cL3J+imffmRQEVF
         oeLceOquvgWMcwNv6kSLnM/ZOeg0z8mfayYPrGvt76z2yJSw9A6PTJsLClOVuPIXaTRU
         Xo4w==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsLxTT8tBC0jCGaRiPKA4ldXuPtn95RVdRYCQUgYXBDo8T6RFvfRmQIulmXBfgCpDe9piI7Bw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520337904; cv=none;
        d=google.com; s=arc-20160816;
        b=HnBDZb1wXV3PuYRQ5TFuPr2iamAuLjkrgWX0m8tfQIuESH7T9+yYDI0jxQ5zCzfQp/
         6u14PN5/zCYTO2L8xxR+JY9C1yZm4b0l02+VlZv0tFSc7iAaXsbh1k2sCGGbGHBOcMt4
         FG8aVqzA4VPc9EjWZ5i+XkZ5smSuP6O/YrFHrMaR5H/wLyvFd8yx8lah9Q9UpYoJm4ak
         fUWlsJJdFE/Jt1RpwziCtdZGOXuHb85QJ/1b1RZAe7lYaHDlCLN4UqbSdyjQYtiU9eqi
         qwAPYinfhO+D+aszrymRfDxwS+s7bsc8Trx8lMYK0besz04x0CZKuAanuP8YqkSYL50h
         hCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=f+50vFtpY5Y/ZrmDmxcp+4vOrnTCNev5sU+orCnuUQQ=;
        b=d4On70uBWU8aCUqJIeEInXbVu+2UZLcGSIewcpQzQDPV73AonfbYXkWVeqromnFUBZ
         RFze0M+VgQX9IA3Rjw0jx+ZHtP9SbXH+6pj5tpbuSdz+tYsxsASDMGHWU3Kgt1950bdm
         Fn3CPjorrnjfQIbEs8GhauFE81l+1y4Ka3fI10CzOyJqwPMiq6888GbkfgpxpR8fuYM5
         nQELMcLXRC4l6JdEmxI1joZQCqbgWjLasIxgpgIQlMNJQnxDgxHj0jSqGb8GackN9HNy
         pHX3DmzNOn/Ef7Ds4BhnyCKOgAWRCnDx5SRXrRNU6O+u3mqr+sKS6uqDD+ks6XSescCm
         gdsw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Date: Tue, 6 Mar 2018 04:05:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
	linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] Re: [PATCH v2] staging: rtl8192u: Replace printk()
 with appropriate net_*macro_ratelimited()
Message-ID: <20180306120506.GA26600@kroah.com>
References: <20180305073256.GA4347@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180305073256.GA4347@seema-Inspiron-15-3567>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Original-Sender: gregkh@linuxfoundation.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12
 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594082150118827439?=
X-GMAIL-MSGID: =?utf-8?q?1594189839957661227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:02:56PM +0530, Arushi Singhal wrote:
> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
> Indentation is also changed, to fix the  checkpatch issue if line is not
> exceding 80 characters.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *change the subject line, in v1 driver name was wrong.
> 
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> index e6648f7..200fe5f 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
>  
>  	priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(priv->tfm)) {
> -		printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
> +		net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");

Why would this need to be ratelimited at all?

Same for the other changes in this file.  Only use the _ratelimited()
calls if the message can be triggered a lot.

> @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  	keyidx = pos[3];
>  	if (!(keyidx & (1 << 5))) {
>  		if (net_ratelimit()) {
> -			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
> -				hdr->addr2);
> +			net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
> +					    hdr->addr2);

Also, "ratelimit" is already checked right above this, so that's a hint
you don't need to check it again :)

thanks,

greg k-h

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180306120506.GA26600%40kroah.com.
For more options, visit https://groups.google.com/d/optout.
