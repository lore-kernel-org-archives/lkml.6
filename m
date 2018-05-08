Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbeEHMgi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:36:38 -0400
Received: from mail.us.es ([193.147.175.20]:42232 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeEHMgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:36:36 -0400
Date: Tue, 8 May 2018 14:36:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: fw@strlen.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [iptables v2] extensions: libip6t_srh: support matching
 previous, next and last SID
Message-ID: <20180508123632.2wgwnk2d2cax66fq@salvia>
References: <1524652247-1749-1-git-send-email-amsalam20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524652247-1749-1-git-send-email-amsalam20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:30:47AM -0500, Ahmed Abdelsalam wrote:
> This patch extends the libip6t_srh shared library to support matching
> previous SID, next SID, and last SID.

Applied, thanks.

Please, send us a patch to add tests for extensions/libip6t_srh.t
