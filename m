Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeCGI2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:28:36 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33511 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeCGI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:28:32 -0500
X-Google-Smtp-Source: AG47ELtYCNd8HWZNYUdpaA+5eUTM+ViyV0pnMNcCaRIY7z/jp6/o6pQI+wgDuWCjYJiW9YjfNTF/vQ==
Date: Wed, 7 Mar 2018 09:28:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20180307082829.jh7t2mn7cvegb4ry@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171126191925.zowfpduhyic5w4n5@pali>
 <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2017 13:13:01 Karel Zak wrote:
> On Sun, Nov 26, 2017 at 08:19:25PM +0100, Pali Rohár wrote:
> > On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> > > Go ahead and send patch :-) (also with LABEL_FATBOOT=)
> > 
> > Ok, I prepared patches for util-linux including LABEL_FATBOOT:
> > https://github.com/karelzak/util-linux/compare/master...pali:master
> 
> Seems good. I'll wait for official pull request. Thanks!
> 
> > I have not created official pull request on github yet as Andreas have
> > not decided yet about dosfstools/fatlabel...
> 
> OK.

Andreas now accepted this change into dosfstools project so I created
official pull request: https://github.com/karelzak/util-linux/pull/586

-- 
Pali Rohár
pali.rohar@gmail.com
