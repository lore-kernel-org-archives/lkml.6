Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9626B2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aaathats3as.com header.i=@aaathats3as.com header.b="086g44fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaathats3as.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeI2H1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:27:06 -0400
Received: from cock.li ([185.100.85.212]:49148 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeI2H1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:27:06 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaathats3as.com;
        s=mail; t=1538182844;
        bh=Bnd9UVOl+tvS94WgK/OcX7fsx2wiKXJIyCgVy3dMVws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=086g44fdUfhZuyPXRFDloaaRgO1uo1gXDo1uV+B/eEGJRuzDZbm7GegrbleUTgYtv
         AxTwEpsC683TiPp+dfr+OdKXzOurZf85UGWw5RGRrjZrwJI0ZfnTU5vKUXYJRRbVZD
         oxzaUZIJp7+nq4nlk/wCw0InfffCbf8+UrFYeHIJV+a+Cacdvqa7DtgZVu0vRXVke/
         K38/TQvCIXIi+c0aLnyiAup8u4SmB7aspV0ZdChSOJY4B/RCwv3udokyQ0HY/U4qQB
         AmHKnpUV2GzDdTMTRXpib0ita1tzQebrY/c94WzjL/vM4vvkSxzeBzjR5/AjOorC8K
         B8IccjzM+ndhA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Sep 2018 01:00:44 +0000
From:   freedomfromruin@aaathats3as.com
To:     freedomfromruin@aaathats3as.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Licenses and revocability, in a paragraph or less.
In-Reply-To: <20180928035648.GA27803@thyrsus.com>
References: <6ed65e31150937cad0733374eb8a9ef4@aaathats3as.com>
 <20180928035648.GA27803@thyrsus.com>
Message-ID: <652e8c520f843e30577cde48e7895de1@aaathats3as.com>
X-Sender: freedomfromruin@aaathats3as.com
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is imperative that the people know their rights so that they are not 
taken advantage of by moneyed interests.

For those who are dispossessed there are remedies at law and in equity.

Here we have a situation where moneyed interests have found a social 
exploit to leverage into ascendancy, while
those who created the edifice which they have willed to conquer are shut 
out.

On 2018-09-28 03:56, Eric S. Raymond wrote:
> freedomfromruin@aaathats3as.com <freedomfromruin@aaathats3as.com>:
>> As has been stated in easily accessible terms elsewhere:
>> "Most courts hold that simple, non-exclusive licenses with unspecified
>> durations that are silent on revocability are revocable at will. This 
>> means
>> that the licensor may terminate the license at any time, with or 
>> without
>> cause." +
> 
> Furthermore, license revocation is not the only option. In Jacobsen
> vs. Katzer (535 F.3d 1373 (Fed. Cir. 2008) it was found that
> open-source developers have an actionable right not to have their
> software misappropriated even though the resulting damages are only
> reputational rather than monetary.
> 
> Under that theory, developers can seek an injunction against a
> misappropriating party without globally revoking their license.
> The application of that case law to this situation is left as
> an easy exercise for the reader.  Any competent paralegal could
> write the brief in an evening. Hell, I could almost do it myself.
> 
> I do not personally want to see this happen.  But that it is possible
> is a fact all parties must deal with.
