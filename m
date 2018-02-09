Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeBIVVg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:21:36 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:56482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750993AbeBIVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:21:35 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4184:4321:5007:8660:9025:10004:10400:10848:11232:11658:11854:11914:12043:12296:12324:12663:12740:12760:12895:12903:13069:13148:13230:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21324:21433:21451:21611:21627:30054:30060:30062:30075:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: top51_2ab8996490057
X-Filterd-Recvd-Size: 1878
Message-ID: <1518211292.14014.34.camel@perches.com>
Subject: Re: New project: get_maintainer.pl web app
From: Joe Perches <joe@perches.com>
To: Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeremy Cline <jcline@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Date: Fri, 09 Feb 2018 13:21:32 -0800
In-Reply-To: <8089f485-a0f6-aa5f-ad19-16b69eb07f46@redhat.com>
References: <8089f485-a0f6-aa5f-ad19-16b69eb07f46@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 13:07 -0800, Laura Abbott wrote:
> Hi,
> 
> get_maintainers.pl has been the standard script for figuring out where to
> send patches or bug reports. It has the disadvantage of requiring a kernel
> tree to actually run though, which makes it harder for bug reports to
> came in. I've started working on a small project to expose get_maintainers.pl
> as a web app. This would let users enter information from a patch or crash
> and call out to get_maintainers.pl. The current project just lets users
> enter in a file path and it displays the output as is. There's lots of options
> for what we could do with the output (omitting e-mails for those maintainers
> who don't want to participate, printing out more helpful warnings etc.)
> 
> The project is at https://pagure.io/get_maintainers and is not even close
> to ready for primetime (passing data to get_maintainer.pl almost certainly
> needs more thought). I'm mostly interested if anyone else would find this
> useful or has general feedback.

Is there a website already setup too?
