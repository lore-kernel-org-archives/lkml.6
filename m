Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeBSR1h convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:27:37 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:54368 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeBSR1f (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 19 Feb 2018 12:27:35 -0500
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] CIFS: fix sha512 check in cifs_crypto_secmech_release
In-Reply-To: <20180219171113.GA16636@embeddedgus>
References: <20180219171113.GA16636@embeddedgus>
Date: Mon, 19 Feb 2018 18:27:32 +0100
Message-ID: <87zi4428l7.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> It seems this is a copy-paste error and that the proper variable to use
> in this particular case is _sha512_ instead of _md5_.

*sigh* I re-read this a lot yet still missed it. Minor memory leak
 fixed, good coverity catch and thanks for the fix!

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
