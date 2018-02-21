Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AH8x225Fxp8LjOdDaqZGrunGWXbbgBhGPkNI7jjYnVcxSOmJQYEwC8TxkSr+HF0xOsx5vz7u84GN
ARC-Seal: i=1; a=rsa-sha256; t=1519246743; cv=none;
        d=google.com; s=arc-20160816;
        b=op9UaACEnzZhWby04aFHY2PRAUR1GrzxtavGTCJX9hqu+cUNBbzRHjJX3XVMHTl09C
         9gi7JNoYeetJmBXyeaLmoTgn+yHxY61uSXkbnfIbjF8kJNHrdDYvxpJ3tgt+IEoR5UPo
         /btOilU76xzMyWY//wogIPZmqeDNkwEl9Ukwr4NbDdy1ZG7ruYu+wU84uUJN0omWKadP
         rzWt5jq0EylyCTb77NBd4lGep94tCNWs/75C2TnXhkpkd4beGnbCkfHEypYZlJ9ZxHdc
         j4++u3ExYuBJo7n9mXT0u1qVuWqMZfPWobzcy3SGORgcEn00lTMz0CoihZRiU6a174QE
         1mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=hseAJvTLjpEFxjHX34AM53zsq0h6YC++SJoOYndmZjw=;
        b=NyvD0BVI1scUkogxLA9nUlTNSAUU8lR1s3iB4QBnyVf0O7ae7jyx+6JV8lav4+mvtE
         vXG01dgNLdmSy0RMhRMvU1OHvlnZWesfHIwHY9z3oEay0K5EY8i1KD0YV7d279xDYuKW
         ssY+rCBhw1fO0sdl6gO53YLtsD854lXQgonqdSvZEAmcs9+Yev++lk5mYhSCRMhaFIOa
         qwb3zo9IPhCizMtFEsYYSjhUYvStrM2xDUcDnNl2r+Dv/5MglQZloy/4HFElQ+7uQFMD
         Mva060lgWBEMT/3A+3qfknQTNqIaNiEk9XdxRhSa21S3+p1vCYEZYJwnk73FSCXStywv
         i0jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: arnd@arndb.de,  hpa@zytor.com,  davem@davemloft.net,  dave.hansen@linux.intel.com,  tglx@linutronix.de,  mingo@redhat.com,  x86@kernel.org,  anthony.yznaga@oracle.com,  pombredanne@nexb.com,  jroedel@suse.de,  gregkh@linuxfoundation.org,  viro@zeniv.linux.org.uk,  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,  sparclinux@vger.kernel.org,  Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
	<cover.1519227112.git.khalid.aziz@oracle.com>
	<b1712b03774934c31afd9e394f07aae51eca74f8.1519227112.git.khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 14:58:32 -0600
In-Reply-To: <b1712b03774934c31afd9e394f07aae51eca74f8.1519227112.git.khalid.aziz@oracle.com>
	(Khalid Aziz's message of "Wed, 21 Feb 2018 10:15:43 -0700")
Message-ID: <874lmaf4av.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eobTf-00022L-FD;;;mid=<874lmaf4av.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX186vhBzoFbhv2ZE/tTURU0ypTSovoIfJqU=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Khalid Aziz <khalid.aziz@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 640 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 3.0 (0.5%), b_tie_ro: 2.0 (0.3%), parse: 1.28 (0.2%),
	extract_message_metadata: 33 (5.2%), get_uri_detail_list: 3.3 (0.5%),
	tests_pri_-1000: 14 (2.3%), tests_pri_-950: 1.97 (0.3%), tests_pri_-900: 1.72
	(0.3%), tests_pri_-400: 36 (5.6%), check_bayes: 34 (5.3%), b_tokenize: 14
	(2.1%), b_tok_get_all: 9 (1.4%), b_comp_prob: 4.3 (0.7%), b_tok_touch_all:
	3.8 (0.6%), b_finish: 0.79 (0.1%), tests_pri_0: 535 (83.5%),
	check_dkim_signature: 0.91 (0.1%), check_dkim_adsp: 4.7 (0.7%),
	tests_pri_500: 9 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v12 01/11] signals, sparc: Add signal codes for ADI violations
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031714313554791?=
X-GMAIL-MSGID: =?utf-8?q?1593045672907378260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> SPARC M7 processor introduces a new feature - Application Data
> Integrity (ADI). ADI allows MMU to  catch rogue accesses to memory.
> When a rogue access occurs, MMU blocks the access and raises an
> exception. In response to the exception, kernel sends the offending
> task a SIGSEGV with si_code that indicates the nature of exception.
> This patch adds three new signal codes specific to ADI feature:
>
> 1. ADI is not enabled for the address and task attempted to access
>    memory using ADI
> 2. Task attempted to access memory using wrong ADI tag and caused
>    a deferred exception.
> 3. Task attempted to access memory using wrong ADI tag and caused
>    a precise exception.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
> v10:
> 	- Updated si_code definitions to match other definitions
>
>  arch/x86/kernel/signal_compat.c    | 2 +-
>  include/uapi/asm-generic/siginfo.h | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index ac057f9b0763..41cf5996a2a9 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
>  	BUILD_BUG_ON(NSIGFPE  != 13);
> -	BUILD_BUG_ON(NSIGSEGV != 4);
> +	BUILD_BUG_ON(NSIGSEGV != 7);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 4);
>  	BUILD_BUG_ON(NSIGCHLD != 6);
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 85dc965afd89..e94f03b3ee6f 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -246,7 +246,10 @@ typedef struct siginfo {
>  #else
>  # define SEGV_PKUERR	4	/* failed protection key checks */
>  #endif
> -#define NSIGSEGV	4
> +#define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
> +#define SEGV_ADIDERR	6	/* Disrupting MCD error */
> +#define SEGV_ADIPERR	7	/* Precise MCD exception */
> +#define NSIGSEGV	7
>  
>  /*
>   * SIGBUS si_codes
