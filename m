Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeEALEk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:04:40 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52838 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeEALEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:04:38 -0400
X-Google-Smtp-Source: AB8JxZr39lYQolrVpZ14TBRZ6RuIdvX8KPI2bIUr+B52g1EJi09Ahmq26BddbBdjXpPEulQm53ZF8ggX61fI9WwvKAE=
MIME-Version: 1.0
In-Reply-To: <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
 <1525165387.23227.44.camel@petrovitsch.priv.at> <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 1 May 2018 13:04:36 +0200
Message-ID: <CAFLxGvxpe78WhrEKcKRt5XRBMtT-mZUe9Bm=sQsn8-f1TnX0eQ@mail.gmail.com>
Subject: Re: Suggested new user link command
To: Tony Wallace <tony@tony.gen.nz>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 12:58 PM, Tony Wallace <tony@tony.gen.nz> wrote:
> Good point.  But there are gid and uid fields in inode disc record.
>
> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Inode_Table
>
> I assume these can be use to ensure that the directory in which it is to
> be placed has permissions to accept the inode.  If that is not the case
> then it would have to be a root only syscall.

Before we dig into details, please come up with a very good use case. :-)
But I'm with Bernd, I don't think it is worth the permissions hassle.

-- 
Thanks,
//richard
