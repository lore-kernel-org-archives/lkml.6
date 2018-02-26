Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBZIMS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:12:18 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41449 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeBZIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:12:15 -0500
X-Google-Smtp-Source: AH8x2260ZTvw0Z9BQTC3y9ft+OLrLACxOzfLjLFh2Orh2w8HZaj5bJUXoJwhr9XxFMAykskO0bY8uA==
Date: Mon, 26 Feb 2018 17:12:10 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180226081210.GF12539@jagdpanzerIV>
References: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
 <20180214055747.8420-1-sergey.senozhatsky@gmail.com>
 <20180220012429.GA186771@rodete-desktop-imager.corp.google.com>
 <20180226054927.GA12539@jagdpanzerIV>
 <20180226055804.GD112402@rodete-desktop-imager.corp.google.com>
 <20180226065035.GD12539@jagdpanzerIV>
 <20180226074652.GB168047@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226074652.GB168047@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/18 16:46), Minchan Kim wrote:
[..]
> > hm, I think `huge_size' on it's own is a bit general and cryptic.
> > zs_huge_object_size() or zs_huge_class_size()?
> 
> I wanted to use more general word to hide zsmalloc internal but
> I realized it's really impossible to hide them all.
> If so, let's use zs_huge_class_size and then let's add big fat
> comment what the API represents in there.

Will do. Thanks!

	-ss
