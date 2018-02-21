Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x224xMNPf0kZNI0WVRPAS6rIzrMYeTACpH24F5ljiNfTKsgb0d5+1y1yV32yCU995Ly9ebIBC
ARC-Seal: i=1; a=rsa-sha256; t=1519209976; cv=none;
        d=google.com; s=arc-20160816;
        b=ojXk4zrrSQjcmVVQfmo5MCoFX3f/uCqXxswpkYNtcM8z+hzI5bLhyxA86ElVXt4B8g
         eIOaENC8qb2yj4qxFABOd3m2pOt6IpWl04yneEJMJNu54nywz9d1ySVGEyfeIElyk4ie
         LJfbEVskdJFR85Nrq1K+POTjXOhc+grdff7iJubTPP6yaeacgevHUKpDtXhShv3FT9sj
         DjikHDM31snzNzuSB8/PRHfY/9nReeSzs/5fAYnNwk2O50GEVouCqXA8Cc6QqvzYeHdl
         gyR6RufENKWcoCWuC81zXdZ9IhEJan2E5bHBbT9PX0+RRi3djH+euGDzH82eL9cu56AT
         BlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=oZV6V5mGeBRy9Xktbb6tA0ASA5GFk0pbZ7hSWHUjQV8=;
        b=aob2jMKLkmT5MaaS6OB2MFYqWPo7QLdlbuzt2Puexf5078w4EY4xk4rR3Jx7wV5lNZ
         FWddgL/4HOrbBSF0pCST3kHSc6OpkOs9UTDagAq5rCocdBdlGwEZ1WHmY76kAJT28eqf
         xYcZZOG7KLg3RX1ml/oBE/OWsvfaQuE1WdPFC4rd9FOR6UJeP2brllOjil0ZPl2PI8GC
         LHCKbIA7ydrYszVXUvk/1ZCINNguF4RS6+maGsz2ZCExZsbQK+C9T7J+LVFZ02n6lkfE
         diz5VH5RxAVJRewoG6aCFJ4hIGq+zrviKC7bf5Pda0GHsDuxC6J+sxq/0DY3aDuztuHE
         LMKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=o6Ri5gMm;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=o6Ri5gMm;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 21 Feb 2018 13:45:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
        devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: hci: Changed camel-case to snake-case.
Message-ID: <20180221104558.r7qgxyqshy37gej6@mwanda>
References: <20180221103928.19599-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221103928.19599-1-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210132
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593006710117877151?=
X-GMAIL-MSGID: =?utf-8?q?1593007120185064859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 02:39:28AM -0800, Quytelda Kahja wrote:
> Changed a variable name from camel to snake case to fix a coding style
> issue.
> 
> Signed-off-by: Quytelda Kahja <quytelda@gmail.com>
> ---
>  drivers/staging/gdm724x/hci_packet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
> index 22ce8b9477b6..f8837c7103ac 100644
> --- a/drivers/staging/gdm724x/hci_packet.h
> +++ b/drivers/staging/gdm724x/hci_packet.h
> @@ -50,7 +50,7 @@ struct tlv {
>  struct sdu_header {
>  	__dev16 cmd_evt;
>  	__dev16 len;
> -	__dev32 dftEpsId;
> +	__dev32 dft_eps_ID;

I bet this is a part of the user space ABI or there is a specific reason
for the name to match the spec or something so it can't be changed...

regards,
dan carpenter
