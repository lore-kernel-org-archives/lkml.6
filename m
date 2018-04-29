Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZo1ikAutEVLfmlD30Pim1wB2dV2GcBW3nDtys3oORAC5LpGSU5Vrzi1eu4BFM8q04hUSPUW
ARC-Seal: i=1; a=rsa-sha256; t=1524975847; cv=none;
        d=google.com; s=arc-20160816;
        b=ay5EPMISKWbQY0+j9gmTlqKBcKkojInL9oIoPOq7SYBPnG7r43D/6CL0CoFXDGmzSD
         la/4FYoOzebdqdDZ1XhYKan9oPxnT1MI/hHJhgyrwFEktHra73mTgwvM8h8Kfo93w5ql
         q80iB8+FUdPEhAgtED33MNslY8QBYW+nYGd/jcpmkXBnuVX61Nd415Kf/3xBnTapY6aH
         y+Er/GSOeLsRnI7ug8X5BbTDy9uOEHwFnMtZOpN+t+UUosNh8SEa+cpQJ31Tr21yjuPO
         ZSHftrCfFCgW2JMj4uVgA9r1/J/BcnzVS3KcBa7rG0Jov7lyILYWLPSWgG7FtXiTR615
         pyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=GlVFZVOqyxVeu6i3Xcu9qNiruxpgmC7EsX/fXrGK3b8=;
        b=DcCQV0l2VXUmCMGJYJyO7fatjKS7u8dd46yjAeRoXBLuArSdafSXwvrLN1KlAWJkqn
         JpRLJTelvRlbxKEFy/BFB9UhxCnBTdXeFyyBksNHy1/+w7I+gKLBFJEfAzGqx+O9clD0
         wIcxNDeoIJi8ap5Q+hjZ2yLEeupBRCy8DXR7iaTBh0DasYKx1HNf9tWY2LDCae5tDsLa
         FMBxXAvEMDO885FQBu7P/d8UgIo+910knRCT8Ej1spjbcaoiDYOtHwQEHc990yBlK+So
         ieMmLXZkWOOAoogMuZr8GG6lzM2kTWfAOaKERmvjVSYhuqw8RO/jVagT+Z86pngy5d5Z
         LX7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180428192025.2075-1-christian.brauner@ubuntu.com>
	<20180428192025.2075-3-christian.brauner@ubuntu.com>
Date: Sat, 28 Apr 2018 23:23:58 -0500
In-Reply-To: <20180428192025.2075-3-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Sat, 28 Apr 2018 21:20:25 +0200")
Message-ID: <87in8ad4ip.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fCdsY-0005yb-Ue;;;mid=<87in8ad4ip.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uILcuZt6+kU04S0kcBSB4hzR6PFTCYSw=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4723]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 145 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 2.7 (1.8%), b_tie_ro: 1.85 (1.3%), parse: 0.69 (0.5%),
	extract_message_metadata: 2.0 (1.4%), get_uri_detail_list: 0.56 (0.4%),
	tests_pri_-1000: 3.5 (2.4%), tests_pri_-950: 1.13 (0.8%), tests_pri_-900:
	0.96 (0.7%), tests_pri_-400: 14 (9.7%), check_bayes: 13 (9.0%), b_tokenize:
	4.4 (3.1%), b_tok_get_all: 3.9 (2.7%), b_comp_prob: 1.25 (0.9%),
	b_tok_touch_all: 1.97 (1.4%), b_finish: 0.56 (0.4%), tests_pri_0: 109 (74.8%),
	 check_dkim_signature: 0.45 (0.3%), check_dkim_adsp: 2.8 (1.9%),
	tests_pri_500: 4.3 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 2/2 v4] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599018883940568849?=
X-GMAIL-MSGID: =?utf-8?q?1599053073693211736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> +	/* fix credentials */
> +	if (owning_user_ns != &init_user_ns) {
> +		struct netlink_skb_parms *parms = &NETLINK_CB(skb);
> +		kuid_t root_uid;
> +		kgid_t root_gid;
> +
> +		/* fix uid */
> +		root_uid = make_kuid(owning_user_ns, 0);
> +		if (!uid_valid(root_uid))
> +			root_uid = GLOBAL_ROOT_UID;
> +		parms->creds.uid = root_uid;
> +
> +		/* fix gid */
> +		root_gid = make_kgid(owning_user_ns, 0);
> +		if (!gid_valid(root_gid))
> +			root_gid = GLOBAL_ROOT_GID;
> +		parms->creds.gid = root_gid;

One last nit:

	You can only make the assignment if the uid is valid.
        Leaving it GLBOAL_ROOT_UID if the composed uid is invalid.
        AKA

		/* fix uid */
		root_uid = make_kuid(owning_user_ns, 0);
		if (uid_valid(root_uid))
                	parms->creds.uid = root_uid;

                /* fix gid */
		root_gid = make_kgid(owning_user_ns, 0);
                if (gid_valid(root_gid))
                	params->creds.gid = root_gid;


One line shorter and I think a little clearer.  I suspect
it even results in better code.

Eric
