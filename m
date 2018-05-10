Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZoFJlq9q6IHXuQstr33gDn6k0p3Jzf0ruBVdEWWH+t12Z3KY4easUMdJA+3WXDfmP0TnqEl
ARC-Seal: i=1; a=rsa-sha256; t=1525919717; cv=none;
        d=google.com; s=arc-20160816;
        b=rT2S53vY2gWNfQZbU1vDB9fbWP0N6mBc04D2VD4zfd1YfWAEX6Qcq+Q8O1nMGFo4UV
         97DxxvBOVqfH7jdzIFX3DNTDxZJqHiyPxktpOwhekpAh6duQFOGHDkoVVtgX7erq8EEM
         08MyQ1M0VpGOZdEz3TE7I7/EMvpDsL8CIpMdRu3oD9LgXUOhwW34P6ZPk2P3c/bC0Z0p
         h51Lb4caUqWh4WY05LWLoQcJ05PVe8JVqTZWqEDpwxGbhEpTJ4ke7bp28VDvtB7ZfYVB
         GeuEhXy5XHpadVwDHrNfKF48bJ4s9Qp4WuJLf+m3UfzoiNojwzG0NyXHcFdLpv18C1oK
         4GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=aZNk8dPC7iQWCM4P04xWd+ob21sInqdvxsuj48YNDaY=;
        b=hB6qIk/Vk3ig8FmMdwC0SkyVOMjbAzl479LDf/gXMi3m342XHOf4Aq43wK63+o/q2l
         uPRhtdm+X0+oQlk9cSJoTC4gO3qBJ3IKTKA0XzpKfUbFIE22Mlc6NPM/0ItJYo/lyNid
         0lhUY/aV8S3t2TvlyANVnXD+kYkJbJZ1UgzyhqBm4n6iBfiXL3w/UaVLBp9PH3UHlDqv
         T738Tz1zehL4GRxXyYZyDvv7IQEvJoNbNzOgzg7SIjFXThIjpyNsIr7vTITcH7bvFchZ
         JifEjHZbEjMXTh4JdOEzsK9Uoi2R7NARaTa7/JuAbI7nM7y5zZ9JQr4XEM85l+3k94J0
         9ruA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>,  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Alex Williamson <alex.williamson@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,  David Howells <dhowells@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Gargi Sharma <gs051095@gmail.com>,  Geert Uytterhoeven <geert+renesas@glider.be>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kirill Tkhai <ktkhai@virtuozzo.com>,  Mike Rapoport <rppt@linux.vnet.ibm.com>,  Oleg Nesterov <oleg@redhat.com>,  Pavel Tatashin <pasha.tatashin@oracle.com>,  Rik van Riel <riel@redhat.com>,  Robin Murphy <robin.murphy@arm.com>,  Russell King <linux@armlinux.org.uk>,  Thierry Reding <treding@nvidia.com>,  Todd Kjos <tkjos@google.com>,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
	<87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
Date: Wed, 09 May 2018 21:35:07 -0500
In-Reply-To: <20180509152505.GA25559@xps15> (Mathieu Poirier's message of
	"Wed, 9 May 2018 09:25:05 -0600")
Message-ID: <87k1scs0f8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGbQH-0003QX-V7;;;mid=<87k1scs0f8.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NAGzXkXn9RDSOSwVAzc1nMqSeWHrc7QI=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mathieu Poirier <mathieu.poirier@linaro.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 327 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 3.1 (0.9%), b_tie_ro: 2.1 (0.7%), parse: 1.00 (0.3%),
	extract_message_metadata: 15 (4.5%), get_uri_detail_list: 1.64 (0.5%),
	tests_pri_-1000: 5 (1.7%), tests_pri_-950: 1.17 (0.4%), tests_pri_-900: 1.03
	(0.3%), tests_pri_-400: 26 (8.1%), check_bayes: 25 (7.7%), b_tokenize: 8
	(2.6%), b_tok_get_all: 8 (2.5%), b_comp_prob: 2.8 (0.9%), b_tok_touch_all:
	3.8 (1.2%), b_finish: 0.56 (0.2%), tests_pri_0: 187 (57.2%),
	check_dkim_signature: 0.71 (0.2%), check_dkim_adsp: 2.2 (0.7%),
	tests_pri_500: 83 (25.5%), poll_dns_idle: 69 (21.2%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1600042794394238634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On Tue, May 08, 2018 at 11:59:38PM -0500, Eric W. Biederman wrote:
>> Kim Phillips <kim.phillips@arm.com> writes:
>> 
>> > This patch is in the context of allowing the Coresight h/w
>> > trace driver suite to be loaded as modules.  Coresight uses
>> > find_task_by_vpid when running in direct capture mode (via sysfs)
>> > when getting/setting the context ID comparator to trigger on
>> > (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
>> 
>> Aside from my objection about how bad an interface a pid in sysfs is.
>> The implementation of coresight_vpid_to_pid is horrible.
>> 
>> The code should be just:
>> 
>> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
>> {
>> 	rcu_read_lock();
>>         pid = pid_nr(find_vpid(vpid));
>> 	rcu_read_unlock();
>> 
>> 	return pid;
>> }
>> Which takes find_task_by_vpid out of the picture.
>
> Many thanks for pointing out the right way to do this.  When Chunyan added
> this feature she broadly published her work and find_task_by_vpid() is the
> function she was asked to used.

Clearly no one was thinking through the implications of a sysfs file
which does not have pid namespace support on namespacing.  I am quite
upset at this mess of an API.  It is not a maintainable way to do things.

>> But reading further I am seeing code writing a pid to hardware.  That is
>> broken.  That is a layering violation of the first order.  Giving
>> implementation details like that to hardware.
>
> This is how the feature works - as Robin pointed out tracers are designed to
> match pid values with the CPU's contextID register.  The input value has no
> other effect than triggering trace collection, which has absolutely no baring on
> the CPU.

So please tell me how we make the tracer pid namespace aware.  Or is it
guaranteed that only the global root user will use this functionality?

As you are taking a vpid it looks like users with lesser privileges are
able to request this.   From the other reply it appears this is the
value the tracer returns to put in logs.  Perhaps I missed it but I
didn't see anything that translated from the global pid to something
else.  Which would make using this feature in a pid namespace confusing
and a problematic information leak if I have understood what has been
said so far.

Eric
