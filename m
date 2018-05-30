Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753759AbeE3R7v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:59:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38634 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeE3R7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:59:48 -0400
X-Google-Smtp-Source: ADUXVKKU9Y41+4750+IFE/18wpMfRuuIZ2KEASfqduhBaHEEQ2XSzuEEM+6d2lAf84ls2z0v2tx5fQ==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH][next] mailbox: PCC: check for negative count for parse
 failure checking
To: Colin King <colin.king@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180530171429.3172-1-colin.king@canonical.com>
From: Al Stone <ahs3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ahs3@redhat.com; keydata=
 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
 AeZZwq9vgjZvBA==
Organization: Red Hat, Inc.
Message-ID: <0d780988-0e59-a3b7-a7c1-9e3f0d227412@redhat.com>
Date: Wed, 30 May 2018 11:59:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530171429.3172-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 11:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function acpi_table_parse_enties_array can potentially return a
> negative value if parsing fails. Currently the check on the return
> is not checking for errors, so fix this by adding a -ve check too.
> 
> Detected by CoverityScan, CID#1469477 ("Improper use of negative value")
> 
> Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mailbox/pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index fc3c237daef2..87d67922020d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -461,7 +461,7 @@ static int __init acpi_pcc_probe(void)
>  	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
>  			sizeof(struct acpi_table_pcct), proc,
>  			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
> -	if (count == 0 || count > MAX_PCC_SUBSPACES) {
> +	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
>  		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
>  		return -EINVAL;
>  	}
> 

Yup, nice catch.  A little paranoid, but we like that in a kernel :).  Thanks.

Reviewed-by: Al Stone <ahs3@redhat.com>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
