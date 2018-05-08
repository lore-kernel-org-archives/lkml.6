Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeEHOWC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:22:02 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:42240 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbeEHOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:22:01 -0400
X-Google-Smtp-Source: AB8JxZpYEusWC5HfE/TB4p29Hp16H4IdtXmgyLwyShLxuDaasOSF48LwPN2TQKbII3Y8EOl3p0CiGw==
Date: Tue, 8 May 2018 16:21:57 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [iptables v2] extensions: libip6t_srh: support matching
 previous, next and last SID
Message-Id: <20180508162157.ddc38d47331b1bf615dbe31d@gmail.com>
In-Reply-To: <20180508123632.2wgwnk2d2cax66fq@salvia>
References: <1524652247-1749-1-git-send-email-amsalam20@gmail.com>
        <20180508123632.2wgwnk2d2cax66fq@salvia>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2018 14:36:32 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Wed, Apr 25, 2018 at 05:30:47AM -0500, Ahmed Abdelsalam wrote:
> > This patch extends the libip6t_srh shared library to support matching
> > previous SID, next SID, and last SID.
> 
> Applied, thanks.
> 
> Please, send us a patch to add tests for extensions/libip6t_srh.t

Thanks pablo!
I will send you a patch with some test cases. 

-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
