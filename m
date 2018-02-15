Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeBODoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 22:44:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeBODoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 22:44:13 -0500
Date: Wed, 14 Feb 2018 19:44:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] namei: fix hardlink speeling error
Message-ID: <20180215034412.GB5775@bombadil.infradead.org>
References: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 09:28:54PM -0500, Richard Guy Briggs wrote:
>  	 * This ensures that not everyone will be able to create
> -	 * handlink using the passed filedescriptor.
> +	 * hardlink using the passed filedescriptor.
>  	 */

You're changing this line and you didn't feel the need to fix the
missing space or the missing article?
