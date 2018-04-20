Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx49/CX35KFD/hmHe+Re6Z7r1WNQSwaGNU4l3twPc9WjszUe/SE/W80G1GHvmLCQ0uBnK/Uds
ARC-Seal: i=1; a=rsa-sha256; t=1524220372; cv=none;
        d=google.com; s=arc-20160816;
        b=dGYLvU1EmBJ1KhiUAKl/wxUuZ5mvuElDPzLs5yZLr2dkfxjhXyHDvk5Yq4i890Wahf
         rHFK329ssR58K1RLyoovKmVQ13x3SRv6WAh/VRa/Wp0Qrz4rPyNjMUAlrTKc5BWDi1+0
         S2IrRIViZDOiGABeewVe/+2w9Tz0tRg3EUReZQNWXtjPXhi6tDq9zPZi61/YIAmw8LAw
         yjtEoaIUd16RTAN34TegymkgQKTNVBFNZLzWdmxRy/u586SyaPjbMpNQtoMu+hBOc/WN
         kRpGuFDpMvIb1GqTrReYBth65xaBuZHv+1TKQ/bnry317zMJ7AM0BeuQlGcrpSXAXJCg
         nogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=wU2huALV1a5WHfNuKuxtFlwMS6crk97aouJFcjsn21Y=;
        b=q51kEaBAr0uET6ysMa8HzK5ruM9lPDqDI3fDUzIv700Nu5B1++Sk9DfcFXXRB+JybK
         9PaaogpcH3+5w58X5/utXdFnDukKO1lsXxlDQnhCLQ16H8F4SZMT2u5yHjrTCmMzlSt7
         +benrpT8+UaqBA1B8yayzezBf7UC+mh+5PuMUt1fUwU+dZWBAYbth9tmlqZ1WMrHMrSb
         i5418d7npRO3DcfN63Rpu2O6gGwRk2bTnVjYykHjyURZb60IaHquk7lWravJih6COx87
         0w7zGjG4OjRZozfar8ONh5y8mIdLVW2TUaIadJh8d7UL//sgBDSmiM6b3uasp/tClSt2
         qptw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Fri, 20 Apr 2018 12:32:42 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>,
	"Raj, Ashok" <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180420103242.GB13977@pd.tnic>
References: <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420100131.GA14217@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598260901519331893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:01:31PM +0200, Vitezslav Samel wrote:
> > Ok, cleaned up patches with commit messages coming up.
> 
>   Good.

Ok, here they are as a reply to this message. I'm running them here, you
could run them one last time to make sure all is good.

@Ashok: please run them too, before I send them to tip guys.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
