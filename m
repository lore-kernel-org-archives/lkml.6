Return-Path: <abbotti@mev.co.uk>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521197737-2-4188917406874734912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H2 -0.001, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='173.203.187.89', Host='smtp89.iad3a.emailsrvr.com', Country='US',
  FromHeader='uk', MailFrom='uk'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: abbotti@mev.co.uk
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521197737; b=PpGd6mg7CRpUe0Vay2U38RzAfX+AS/eLWzRC/Zgj35TMGQk
    i02a0sYMZn6qzrI/hDWq5J381hxjKvdhEJw9UF9S84TKFQD0X5n5aVE5QUHEkqWK
    iINpBf1bGLdmOVR6CRzbNfcyxGUTEwTyIM8keByUxNjWNGulDSknTAsbsnEWEWa0
    gHlwpY7O63wr7NwuPmUWVPa0SHiFLm0Wos7CgrUEiyiTadTJb+7QeOfn+dpSNL3p
    KHgjiljEIEWe8XmB5JJ77JoBo567nDWaSBSP+DQt8D+3NBhISYFyRGexNAKkGD23
    U80SZCaDkDWxmfBL/bUVeNxECv5hh+Erh4y50oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1521197737; bh=SpFnvHKH
    0Tabari0Ixv2h4BRQs2L9GTEMgjUKA1E74g=; b=DiJg8ZKNJgenrXx5YDYgiOl0
    bHTApL6aoHr4LYj1yhfrrJ9q/Ui+5aZd3AvEno5ZTu9TKn4W5zkU4RJaGEMJQY8H
    ZX1EkfKqmIewH1GlAMHZR2dFGSkDeyau0oM1NXEcxs9oanXX+0ZlJJZ8Ncm9lfwW
    C/wEsRxsTo/PN8btYP887N3K1GR/59yBB0g8sBmiFViD46h/xc2LGqy55ySHk/7+
    4+PTUPGCjClkpYy6VNM1KpvZKxY+SOVJd18wuWgrVLe1Lr75oA8A5pNPX/g+20Vd
    Aqz/GoB6/NhZnzoj/q9zDaG7xgkN9kf49NmuFYllMwKuI20IXr99eu5Y2TpeIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=173.203.187.89 (smtp89.iad3a.emailsrvr.com);
    spf=none smtp.mailfrom=abbotti@mev.co.uk smtp.helo=smtp89.iad3a.emailsrvr.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=smtp89.iad3a.emailsrvr.com x-ptr-lookup=smtp89.iad3a.emailsrvr.com;
    x-return-mx=pass smtp.domain=mev.co.uk smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=173.203.187.89 (smtp89.iad3a.emailsrvr.com);
    spf=none smtp.mailfrom=abbotti@mev.co.uk smtp.helo=smtp89.iad3a.emailsrvr.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=smtp89.iad3a.emailsrvr.com x-ptr-lookup=smtp89.iad3a.emailsrvr.com;
    x-return-mx=pass smtp.domain=mev.co.uk smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Auth-ID: abbotti@mev.co.uk
X-Sender-Id: abbotti@mev.co.uk
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
To: Pratik Jain <pratik.jain0509@gmail.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
References: <20180316103652.jparuok7dsmvu5xp@mwanda>
 <20180316104813.30848-1-pratik.jain0509@gmail.com>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <f5dcd2f4-9935-70c3-44b4-fd25c8b9663a@mev.co.uk>
Date: Fri, 16 Mar 2018 10:55:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316104813.30848-1-pratik.jain0509@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/03/2018 10:48, Pratik Jain wrote:
> Fixed coding style issue.
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>   drivers/staging/comedi/drivers/ni_atmio.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
> index b9e9ab548c4b..2b7bfe0dd7f3 100644
> --- a/drivers/staging/comedi/drivers/ni_atmio.c
> +++ b/drivers/staging/comedi/drivers/ni_atmio.c
> @@ -224,10 +224,11 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
> -		isapnp_dev = pnp_find_dev(NULL,
> -					  ISAPNP_VENDOR('N', 'I', 'C'),
> -					  ISAPNP_FUNCTION(ni_boards[i].
> -							  isapnp_id), NULL);
> +		isapnp_dev =
> +			pnp_find_dev(NULL,
> +				     ISAPNP_VENDOR('N', 'I', 'C'),
> +				     ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
> +				     NULL);
>   
>   		if (!isapnp_dev || !isapnp_dev->card)
>   			continue;
> 

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
