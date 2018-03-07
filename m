Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933992AbeCGQDW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:03:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933335AbeCGQDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:03:19 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/3] certs: define a trusted platform keyring
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31488.1520438598.1@warthog.procyon.org.uk>
Date: Wed, 07 Mar 2018 16:03:18 +0000
Message-ID: <31489.1520438598@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nayna Jain <nayna@linux.vnet.ibm.com> wrote:

> +		key = key_create_or_update(make_key_ref(keyring, 1),
> +				"asymmetric",
> +				NULL,
> +				p,
> +				plen,
> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				 KEY_USR_VIEW | KEY_USR_READ),
> +				KEY_ALLOC_NOT_IN_QUOTA |
> +				KEY_ALLOC_BUILT_IN |
> +				KEY_ALLOC_BYPASS_RESTRICTION);

There's no need to reindent here.  Please line up all the arguments: either
push the first argument over onto the next line if you need to or line them
all up with the char after the opening bracket.

David
