Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AB8JxZqYLmZQlMCTQFD0ISGj9trAGd+TkS4gqfjMHf0DJDMDcCCfuqIbxilZ/psZeLt/RS/6gEcl
ARC-Seal: i=1; a=rsa-sha256; t=1526667645; cv=none;
        d=google.com; s=arc-20160816;
        b=S6WR3UCBQpqAWI/6edTztDXEYNsw/y7Zsb46QRqWBdXhu9N0PC8uMn6BCOsnLn391W
         cUhVU85lwWqcfdHnQc14Cfw/pn3y70gOb5hqe1KQq+JqKr5cEmLsNswKLw/jDid8PphO
         8d+yD9a/3bDs9pOT3lL2/jfZpsLVM7vFZCO8eg1aNKV3SZUhC0mTa3Or7D5QKtzDwPEJ
         DmOqC/afSMyA0wWlnljGNDC4iSTOqvhFR8tKhJ0k8KQqVLW8Wz8LwhGOiovMgsMcgaFX
         JFxh+skb2BYCN8/WKeZ8GhzZil3aX5FFDid4n6K7ajQYdFdzz+raGVFuNdp5HOowBbZg
         Jmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=z3/zKVxQbStOiEkMXL1eYW+J//+9tt4dpbOyRoTEIr8=;
        b=E46QwrXKCmTatdL8QzeVQlSAySnRK31ExJ7rZOUUAFZrFHUjnm3fgOUHMdBhqnHUIo
         14VY+gXEcxZ7fdf6QcbMl4FSGq8DzfnuXOTJo3snbkLViK95izAikybYFCIzrZ1Zm75v
         h+Qi/2TTP7S9XPLDHnWb8kBE82AfV3SGVT3HHKgSBvIQy6hRRIdxFVl2slydw826gjfc
         bvFtMUQdA2UpWjJFK6Hn/hAFphkgYbpmoP955DOCStEURg8SJ2AjPCZSavtUe7xK6l80
         LI92PMA53PE4lzLlnWQNFe09Jiwnu/IAN8PHsUEJOWXdqqpb0WgMw+6uk2dhbhtVAl8p
         4z0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Sat, 19 May 2018 02:20:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: n2: fix spelling mistake: "restesting" ->
 "retesting"
Message-ID: <20180518182035.5esz4h66rssgrgi6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508221842.22198-1-colin.king@canonical.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599936056039744694?=
X-GMAIL-MSGID: =?utf-8?q?1600827052937824592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
