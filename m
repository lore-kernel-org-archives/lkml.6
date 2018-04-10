Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeDJJfa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:35:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50807 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbeDJJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:35:29 -0400
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] cifs: Use ULL suffix for 64-bit constant
In-Reply-To: <1522933031-25574-1-git-send-email-geert@linux-m68k.org>
References: <1522933031-25574-1-git-send-email-geert@linux-m68k.org>
User-Agent: Notmuch/0.22.1 (http://notmuchmail.org) Emacs/25.1.1 (x86_64-unknown-linux-gnu)
Date: Tue, 10 Apr 2018 11:35:26 +0200
Message-ID: <87zi2bqu8x.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On 32-bit (e.g. with m68k-linux-gnu-gcc-4.1):
>
>     fs/cifs/inode.c: In function ‘simple_hashstr’:
>     fs/cifs/inode.c:713: warning: integer constant is too large for ‘long’ type
>
> Fixes: 7ea884c77e5c97f1 ("smb3: Fix root directory when server returns inode number of zero")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

this is already in Steve's for-next, marking as reviewed:

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
