Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeBUSvt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:51:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55972 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeBUSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:51:47 -0500
Date: Wed, 21 Feb 2018 18:51:43 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        avagin@virtuozzo.com
Subject: Re: [PATCH] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180221185143.GJ30522@ZenIV.linux.org.uk>
References: <20180221184411.GA25924@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221184411.GA25924@avx2>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 09:44:11PM +0300, Alexey Dobriyan wrote:

> +	len = strlen(str);
> +	if (len > 1 && *str == '0')
> +		return -EINVAL;

	if (s[0] == '0' && s[1])
please...
