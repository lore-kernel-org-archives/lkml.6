Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx48xlEDrGF6bws3RtMFe+SMmviRzc3tAOv0QOBTjBFqwmTSNMLyqzeqoQKnDF0xH1c19wdBr
ARC-Seal: i=1; a=rsa-sha256; t=1524070637; cv=none;
        d=google.com; s=arc-20160816;
        b=VRkK0tkvrJd2JG+g5YBGlut0HBOXXIq0ydBeOT/FQGyC/wbu2EUKmqzj87OOFSqo8C
         SUT4lQdGHuFnL64rDqbXdoajjcTw58Ujc9mpWgwquz5Eg5d5jWqz9gw6L1jkH9/8ROrC
         4Vv+iBfEG3onlgIkCp+zqWxbY/HGBXpIZcVzboYT5co9XlWWuR8bxi1dBpT6TQ58yKqe
         s3rqf/9BtSk/kRITdD2072Jq7FRPattzbPnjf8/tkjZ70VRUIoLIJxUUCBxoBzbqhMvN
         SykVIf5cu65yGuNG8M++oITHQrubvZBCP266ubhVpnCyhRPNmTfJwtBa1ZqKzkYwmFaY
         KPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=dnm86xTwJflDYNLNB38yLGu5GbRL6m1cdvV2AjE9ViE=;
        b=QbQJXGy/PQ594FsdeUFB6jG11Da6o5LaGIB016AcSfOCPPRBPA6B35XgbNfzaDnZv3
         JVvEW68P2OVZAiBSBRXxyoy2Z1c2RjVE9CTvmday5yAyH64bHHKoWKK9LuBUXtNRO3s6
         sUqCHTtENUAj4d+J4dOAn9s082v9sEaRK9hLQMtL+53snlx875v4vdKmahn/4KRDXKZn
         Z5iFQ/8aX2U0+udf1NlGe05bMPKEnohkK0oI6xouWSmcf87gk1mmd1rzv3mmFz/F+Uy1
         l0cj5TMr7lFeS6VqPgogO921f9mTTltefQeN2ZCDcyH+DFlLtEQBB6AKv1zlumEsQhJB
         UUkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180418152106.18519-1-christian.brauner@ubuntu.com>
	<20180418152106.18519-3-christian.brauner@ubuntu.com>
Date: Wed, 18 Apr 2018 11:55:52 -0500
In-Reply-To: <20180418152106.18519-3-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Wed, 18 Apr 2018 17:21:06 +0200")
Message-ID: <874lk8wj1j.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f8qOQ-0005hU-C7;;;mid=<874lk8wj1j.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MZjt54lassqLMpD9aP7nGReHi1SqMpBA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4993]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 304 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 3.0 (1.0%), b_tie_ro: 2.0 (0.7%), parse: 1.14 (0.4%),
	extract_message_metadata: 23 (7.5%), get_uri_detail_list: 0.90 (0.3%),
	tests_pri_-1000: 8 (2.7%), tests_pri_-950: 2.00 (0.7%), tests_pri_-900: 1.67
	(0.5%), tests_pri_-400: 20 (6.7%), check_bayes: 19 (6.1%), b_tokenize: 7
	(2.2%), b_tok_get_all: 4.6 (1.5%), b_comp_prob: 2.6 (0.9%), b_tok_touch_all:
	2.2 (0.7%), b_finish: 0.81 (0.3%), tests_pri_0: 228 (75.0%),
	check_dkim_signature: 0.78 (0.3%), check_dkim_adsp: 5 (1.7%), tests_pri_500:
	11 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns locks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598103892689286737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Now that it's possible to have a different set of uevents in different
> network namespaces, per-network namespace uevent sequence numbers are
> introduced. This increases performance as locking is now restricted to the
> network namespace affected by the uevent rather than locking
> everything.

Numbers please.  I personally expect that the netlink mc_list issues
will swamp any benefit you get from this.

Eric
