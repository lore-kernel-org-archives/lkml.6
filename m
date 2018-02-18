Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBRRPn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:15:43 -0500
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:44255 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751259AbeBRRPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:15:42 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2194:2199:2393:2525:2553:2560:2564:2682:2685:2828:2859:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7875:9025:9108:9388:10004:10848:11232:11658:11855:11914:12043:12050:12663:12740:12760:12895:13439:14096:14097:14181:14659:14721:14819:14877:21067:21080:21324:21451:21611:21627:21740:30003:30012:30034:30041:30054:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: beam81_1476a40d4a633
X-Filterd-Recvd-Size: 5366
Message-ID: <1518974138.1894.14.camel@perches.com>
Subject: Re: Seeking guidance on spelling fixes
From: Joe Perches <joe@perches.com>
To: David Frey <dpfrey@gmail.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Cc: Colin King <colin.king@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 18 Feb 2018 09:15:38 -0800
In-Reply-To: <7912182.YNFVRYok70@roach>
References: <7912182.YNFVRYok70@roach>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Colin King and Masahiro Yamada, the current
 and former spelling correction leading submitters)

On Sun, 2018-02-18 at 07:34 -0800, David Frey wrote:
> I noticed a common spelling mistake in some Linux kernel code that I was
> reading the other day and it made me wonder how prevalent common spelling
> mistakes are in the kernel.  I did some grepping and it seems that there
> are a large number of spelling mistakes.  I did a bit of searching and I
> found (http://www.kegel.com/kerspell/) which includes some comments/tools
> relating to spelling and the Linux kernel.
> 
> I have gone ahead and corrected about 100 total instances based on 25
> common misspellings.  There are many, many more common misspellings that I
> could check, but I don't want to sink more time into this if the changes
> won't be accepted.
> 
> Is this type of change likely to be accepted?

Yes.  Mostly.  Slowly.

> Right now I am making
> individual git commits for each correction.  For example "aditional ->
> additional".

That's best.
	
> I am trying to only correct true misspellings.  I'm not trying to choose
> the "most correct" spelling for cases where there are acceptable alternate
> spellings.

Right.  Please do not change Britishisms<->Americanisms

> I've pushed the changes I have made so far to a "spelling_fixes" branch
> here: https://github.com/dpfrey/linux/commits/spelling_fixes just in case
> there is any question about what I am doing based on the above description.
> 
> Just to be clear, I'm not trying to get this portion of the work merged at
> this point.  I'm trying to get a feel for whether I should keep working on
> this.

About half a year ago, these were the most frequent
typos checkpatch's spelling test found:

     98 'prefered' may be misspelled - perhaps 'preferred'?
     85 'occured' may be misspelled - perhaps 'occurred'?
     61 'endianess' may be misspelled - perhaps 'endianness'?
     60 'childs' may be misspelled - perhaps 'children'?
     53 'Interrup' may be misspelled - perhaps 'Interrupt'?
     51 'transfered' may be misspelled - perhaps 'transferred'?
     49 'TRESHOLD' may be misspelled - perhaps 'THRESHOLD'?
     48 'trun' may be misspelled - perhaps 'turn'?
     45 'commited' may be misspelled - perhaps 'committed'?
     41 'capabilites' may be misspelled - perhaps 'capabilities'?
     39 'sucess' may be misspelled - perhaps 'success'?
     39 'preemptable' may be misspelled - perhaps 'preemptible'?
     38 'struc' may be misspelled - perhaps 'struct'?
     35 'overriden' may be misspelled - perhaps 'overridden'?
     34 'CONTINOUS' may be misspelled - perhaps 'CONTINUOUS'?
     33 'programm' may be misspelled - perhaps 'program'?
     31 'splitted' may be misspelled - perhaps 'split'?
     30 'PALLETTE' may be misspelled - perhaps 'PALETTE'?
     28 'SUPPORED' may be misspelled - perhaps 'SUPPORTED'?
     28 'interupt' may be misspelled - perhaps 'interrupt'?
     28 'adress' may be misspelled - perhaps 'address'?
     27 'timout' may be misspelled - perhaps 'timeout'?
     27 'calle' may be misspelled - perhaps 'called'?
     26 'ASSIGMENT' may be misspelled - perhaps 'ASSIGNMENT'?
     26 'alow' may be misspelled - perhaps 'allow'?
     23 'seperate' may be misspelled - perhaps 'separate'?
     23 'dependant' may be misspelled - perhaps 'dependent'?
     23 'accomodate' may be misspelled - perhaps 'accommodate'?
     22 'specifc' may be misspelled - perhaps 'specific'?
     22 'continous' may be misspelled - perhaps 'continuous'?
     22 'beeing' may be misspelled - perhaps 'being'?
     21 'retrive' may be misspelled - perhaps 'retrieve'?
     21 'paramaters' may be misspelled - perhaps 'parameters'?
     21 'ouput' may be misspelled - perhaps 'output'?
     21 'ment' may be misspelled - perhaps 'meant'?
     21 'avaiable' may be misspelled - perhaps 'available'?
     21 'Acknowledgement' may be misspelled - perhaps 'Acknowledgment'?
     20 'wether' may be misspelled - perhaps 'whether'?
     20 'changable' may be misspelled - perhaps 'changeable'?
     19 'reseting' may be misspelled - perhaps 'resetting'?
     19 'orignal' may be misspelled - perhaps 'original'?
     18 'managment' may be misspelled - perhaps 'management'?
     18 'lenght' may be misspelled - perhaps 'length'?
     17 'UNDERUN' may be misspelled - perhaps 'UNDERRUN'?
     17 'syncronized' may be misspelled - perhaps 'synchronized'?
     17 'singal' may be misspelled - perhaps 'signal'?
     17 'paramters' may be misspelled - perhaps 'parameters'?
