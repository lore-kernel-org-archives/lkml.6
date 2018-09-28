Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF7021547
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF7021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeI1KSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:18:53 -0400
Received: from thyrsus.com ([71.162.243.5]:32844 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeI1KSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:18:53 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 3D9583A42A1; Thu, 27 Sep 2018 23:56:48 -0400 (EDT)
Date:   Thu, 27 Sep 2018 23:56:48 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     freedomfromruin@aaathats3as.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Licenses and revocability, in a paragraph or less.
Message-ID: <20180928035648.GA27803@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, freedomfromruin@aaathats3as.com,
        linux-kernel@vger.kernel.org
References: <6ed65e31150937cad0733374eb8a9ef4@aaathats3as.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed65e31150937cad0733374eb8a9ef4@aaathats3as.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

freedomfromruin@aaathats3as.com <freedomfromruin@aaathats3as.com>:
> As has been stated in easily accessible terms elsewhere:
> "Most courts hold that simple, non-exclusive licenses with unspecified
> durations that are silent on revocability are revocable at will. This means
> that the licensor may terminate the license at any time, with or without
> cause." +

Furthermore, license revocation is not the only option. In Jacobsen
vs. Katzer (535 F.3d 1373 (Fed. Cir. 2008) it was found that
open-source developers have an actionable right not to have their
software misappropriated even though the resulting damages are only
reputational rather than monetary.

Under that theory, developers can seek an injunction against a
misappropriating party without globally revoking their license.
The application of that case law to this situation is left as
an easy exercise for the reader.  Any competent paralegal could
write the brief in an evening. Hell, I could almost do it myself.

I do not personally want to see this happen.  But that it is possible
is a fact all parties must deal with.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


