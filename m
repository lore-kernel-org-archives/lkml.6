Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933937AbeCGPoS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:44:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933728AbeCGPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:44:17 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
References: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] X.509: unpack RSA signatureValue field from BIT STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30084.1520437454.1@warthog.procyon.org.uk>
Date: Wed, 07 Mar 2018 15:44:14 +0000
Message-ID: <30085.1520437454@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:

> +	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {

I'm going to change this to '== 0' rather than '!'.

David
