Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCTTmR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:42:17 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55466 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbeCTTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:42:13 -0400
Date: Tue, 20 Mar 2018 19:42:03 +0000
From: Sergei Trofimovich <slyfox@gentoo.org>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: corbet@lwn.net, yamada.masahiro@socionext.com, tony.luck@intel.com,
        bjorn.forsman@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modify one dead link
Message-ID: <20180320194203.205c6c60@sf>
In-Reply-To: <20180320145422.24331-1-mudongliangabcd@gmail.com>
References: <20180320145422.24331-1-mudongliangabcd@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018 10:54:22 -0400
Dongliang Mu <mudongliangabcd@gmail.com> wrote:

> -    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
> +    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
>      # cd xen-unstable.hg
>      # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg

You will need to fix a 'cd' as well:
    cd xen-unstable
 
Otherwise looks good.

-- 

  Sergei
