Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2009892-1522777576-2-17013130727292266751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522777576; b=HOYwKZDJUbTeDpq6PIeV89S5XMSGZz1B2bu+vakcMrKwjtEp+0
    4f+t4qN3gh62PgHichpt/2X/x34Ib5H1hDf/+Js+oF0hb1a/eeI3oy8pBBB1qpMy
    eH+9fRKHzbQQqDwe3nizt+DVvnuYQKlUKVSe4pdE9tt1LNhszlGtbHOrO2eJWLhP
    V+3XBk83mvSzRNjzmwMWk5bbY0Uw3qD4ipy4PkrVAkhMORxuCQ5hDYpbCHB5YZK+
    0KktwnqoH2eaxZPlLUF5fNqZNxTbXu24rnsPpTDIuFwW8a06UaMKUsnpQcuOkRBj
    dytDXMFIGZ7eFIuida+uRuuhpNJ6l5HiMN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522777576;
    bh=4hrAFv10wfI/EfcgBYLAirKsAMvFx/KEdYzteGEBnZg=; b=rIWFZdTArAIW
    6e4vY8+IxEkFCz6DyQMYX+COXPXsasuPNzxLJvk58m0UlTDbRXg0KXY9EDQ1OQN6
    D3bYN7pKWnFygjSdeYPDDNBIcCN3vfVg+ZIuISf7K1XuVQ+/dxy08psZcYGyJr0i
    drX15T4aP6qYTvc7DhLxfvDUvHwYoU4zTJcN4AgoR1hu5vY3oE4MVQcQijBllraY
    B9OUHYhTZkKAgeSIO6s4ELzjN8kIDlvV73loNLXayBSvvyeV0SWv1qxzn92WWd7M
    +tKYnODmIMphmYtz3FpcsFJV/OVN4/B2r3Uhw6beh6BWHOpUx5rZDHNQ9UMBuVMv
    J0IbUy6ILw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAFlkLEqwJqRpXhketrU82dxp07go4kOBsfFraWVhp+NRiqgEdVnZNKOdzpbTfTMsqRHvCkvPErIW1iF4NNcNl4Hy2O51va4HKyg5xGJtEygycJdYqEw
    MTVmxG/gd6k9QaUI9Ctrpri0Qjd4aoRSKvvc5IzjRzfe9Yz5prU3xYpSStg4r42LofrgNyrBCgjP0ICdeEVZ3/u2RQ3KI1DnIsg8iGiQLuI6177hHLS/Va6D
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Qze4UBMhAAAA:8 a=66_R0QKGEi1T8MKuxzUA:9 a=QEXdDO2ut3YA:10
    a=30qrNVoKYyQsQ_rTTfpG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDCRqN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 13:46:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59902 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDCRqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 13:46:12 -0400
Message-ID: <1522777564.2654.115.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 38/97] netfilter: xt_CT: fix refcnt leak on error
 path
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Gao Feng <fgao@ikuai8.com>, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 03 Apr 2018 18:46:04 +0100
In-Reply-To: <20180323094159.781131756@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094159.781131756@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Gao Feng <fgao@ikuai8.com>
> 
> 
> [ Upstream commit 470acf55a021713869b9bcc967268ac90c8a0fac ]
[...]
> --- a/net/netfilter/xt_CT.c
> +++ b/net/netfilter/xt_CT.c
> @@ -168,8 +168,10 @@ xt_ct_set_timeout(struct nf_conn *ct, co
>  		goto err_put_timeout;
>  	}
>  	timeout_ext = nf_ct_timeout_ext_add(ct, timeout, GFP_ATOMIC);
> -	if (timeout_ext == NULL)
> +	if (!timeout_ext) {
>  		ret = -ENOMEM;
> +		goto err_put_timeout;
> +	}
>  
>  	rcu_read_unlock();
>  	return ret;

This part looks fine.

> @@ -201,6 +203,7 @@ static int xt_ct_tg_check(const struct x
> >  			  struct xt_ct_target_info_v1 *info)
>  {
>  	struct nf_conntrack_zone zone;
> +	struct nf_conn_help *help;
>  	struct nf_conn *ct;
>  	int ret = -EOPNOTSUPP;
>  
> @@ -249,7 +252,7 @@ static int xt_ct_tg_check(const struct x
>  	if (info->timeout[0]) {
>  		ret = xt_ct_set_timeout(ct, par, info->timeout);
>  		if (ret < 0)
> -			goto err3;
> +			goto err4;
>  	}
>  	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
>  	nf_conntrack_get(&ct->ct_general);
> @@ -257,6 +260,10 @@ out:
>  	info->ct = ct;
>  	return 0;
>  
> +err4:
> +	help = nfct_help(ct);
> +	if (help)
> +		module_put(help->helper->me);
>  err3:
>  	nf_ct_tmpl_free(ct);
>  err2:

This does not.  nf_ct_tmpl_free() calls nf_ct_ext_destroy() which I
think will call back into xt_ct_tg_destroy().  So I think the module
reference is already dropped here and we mustn't do it twice.  Am I
missing something?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
