Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeB1CKc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:10:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeB1CKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:10:30 -0500
Subject: Re: [PATCH v2 6/6] kconfig: rename silentoldconfig to syncconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-7-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6fc6557b-8806-0f5d-671e-eeda67c5e3dc@infradead.org>
Date: Tue, 27 Feb 2018 18:10:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519776926-30459-7-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 04:15 PM, Masahiro Yamada wrote:
> As commit cedd55d49dee ("kconfig: Remove silentoldconfig from help
> and docs; fix kconfig/conf's help") mentioned, 'silentoldconfig' is a
> historical misnomer.  That commit removed it from help and docs since
> it is an internal interface.  If so, it should be allowed to rename
> it to something more intuitive.  'syncconfig' is the one I came up
> with because it updates the .config if necessary, then synchronize
> other files with it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - newly added
> 
>  Documentation/kbuild/kconfig.txt |  2 +-
>  Makefile                         |  2 +-
>  scripts/kconfig/Makefile         |  4 ++--
>  scripts/kconfig/conf.c           | 20 ++++++++++----------
>  4 files changed, 14 insertions(+), 14 deletions(-)

It wouldn't hurt to update this line also: (I would just drop "silentoldconfig")

     Make oldconfig/silentoldconfig/menuconfig/etc.

in Documentation/networking/i40e.txt.


thanks,
-- 
~Randy
