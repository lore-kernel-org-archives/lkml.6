Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2452599-1519373734-2-11156489010236175720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519373733; b=GoclnnMz18RDlkLJpAy4OR9x8ocPsRYlucPmHrnnk08RXjf
    EF+DiGyimmfERDDjqPsrjCOaSjdKF7UiWdvxN/xgKi9tVHt3kAaV3fWG7ijywo0K
    Vhb63eyWrEwAEyVeXMp5Vyun19TgHqeYU9CTa3d68uCezvjH7/9+VVyNPzQuVDwI
    q3oz1DU5C1HxrIGWswWkPRIySRmOwAVBH9xH7dwafnlFJHadT0WfwOniWqHJ6lky
    xjfwGxaDLNvNPz+EMLLQrTNwzwQc1E/wDQIPw+0SNH+G3EQpnZvKgHtMfhn7v0Hw
    SRPA5TstuSNExYr2xKLFyIwU5iJkNj9thKjq8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519373733; bh=u
    aisTvNuBAypuZxnlioEI194pY+GanHtJ9mgWWZ3Psc=; b=le3glNg5VQc1CrCWk
    sETPuuqX2U5T/41zsMYLd/sn+IlUqqxnkhJiBKrPmeinbcrT6zJ8TYwZZTbFcleh
    ZRqS+bRrb7+V3Z/RbVwWQkGtvsYbo8VV0449hAVx3UnSEoNtwIKrGADQlp174lby
    HAQWTZeNUE4gAe6CU5ifGjUbpfh+MsggDSAerpOQP3TV32WLYC8uf01WKK7i81cX
    7lan3xzfqVNbquU8vFja41B0C8vQc8mE6GgxKXQmcLsRTP18ufEecwCApx3v3PUM
    64JhdfyMyFXPL/pdVsRY7PsH0o7Y5p/eV/CUSgwhv4oZCQzT0/pA77jwB3bXzk7X
    cC4sg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
Date: Fri, 23 Feb 2018 09:15:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 2/4] Staging: gdm724x: hci: Changed camel-case to
 snake-case.
Message-ID: <20180223081526.GA12617@kroah.com>
References: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
 <20180223013301.17646-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180223013301.17646-1-quytelda@tamalin.org>
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
Cc: devel@driverdev.osuosl.org, deanahn@gctsemi.com, jonathankim@gctsemi.com,
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 05:32:59PM -0800, Quytelda Kahja wrote:
> Changed a variable name from camel to snake case to fix a coding style
> issue.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
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
>  	__dev32 bearer_ID;
>  	__dev32 nic_type;
>  } __packed;

Why not just delete the whole structure if no one is using it?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
