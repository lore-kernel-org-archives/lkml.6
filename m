Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDDKSG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44775 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbeDDKSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:18:04 -0400
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddeor.com>
Subject: Re: [PATCH v2] cifs: smb2pdu: Fix potential NULL pointer dereference
In-Reply-To: <20180403210039.GA28968@embeddedor.com>
References: <20180403210039.GA28968@embeddedor.com>
User-Agent: Notmuch/0.22.1 (http://notmuchmail.org) Emacs/25.1.1 (x86_64-unknown-linux-gnu)
Date: Wed, 04 Apr 2018 12:18:00 +0200
Message-ID: <87muyjff6v.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:
> tcon->ses is being dereferenced before it is null checked, hence
> there is a potential null pointer dereference.
>
> Fix this by moving the pointer dereference after tcon->ses has
> been properly null checked.
>
> Addresses-Coverity-ID: 1467426 ("Dereference before null check")
> Fixes: 93012bf98416 ("cifs: add server->vals->header_preamble_size")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
