Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x227VXcUGosbtlGDwh0mBnYmXiUKisc3iIDFr9TK4Zi7ALo3nwJveuD1TBeUwj0KzLBTHg59R
ARC-Seal: i=1; a=rsa-sha256; t=1518557293; cv=none;
        d=google.com; s=arc-20160816;
        b=LSx0pQp6mIODWTqaP97m0nWbNtSd5UJYhcEpoHWAkYScZhzb0g7Az+hrKbfvTC+KYx
         /YLCq612h/PnIq0rCXe8vxUekb8wZcrcCzN+s5Mc9+jBvZkqAJDlwPJilgejjb9MvOWc
         qerqk+SqWPtlEVWtxiLtfFNhLxZE5rcZxbPHuP/sKBK/iOAFuXO8iIfwxNQepwM+fbDD
         eBGXsB+W9k1GzNKffyXiugAu2lrkJfmV3/tUh7TMCXLwrSNP+p3EQgB1f8WckSJ+D/Dw
         qHJUH0bCOxLocnY6hDl4wGa1JLInlsyjOPAhkto1q0ygolm734+kRtmDGPcTtB4LghqC
         lW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=51hHplh8jhc58g72h26BDrujiMTKNHPFxOUazpWKuMw=;
        b=m+uH1I5RCyNPRiEPCnFID2Keu0gWEqFi4b21DNHugab5mNgoXiKqN4MG4w0oJJbEdj
         tJtA12JL8LsFrNukXlTW0cDlDeUNiL483ezXY3y5iB8fIqnHiICVhbfR0X4i1tjfIkc7
         doAy5F5ov9mGGwqD9jcGtGRz21rjVdjR6DLdTL+BGJaFQ9EcYAN6DONmvICH0jpbmHsy
         FtBnsFJmvY0RuXPPgBf8jgvMbjHDn1nDFn7QLFfWUToIVpYskFruNZJdRpCjU89lN1lM
         m/nD6dxBxJjSnPCsj0y2V26H96m5aiMwuqh3AqZEeIHrilajrDulZ/DpoGQ0dfOc+8OO
         DZAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests/x86: Remove 5lvl test from Makefile
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc: linux-kselftest@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Dmitry Safonov <dima@arista.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <1518069029-22457-1-git-send-email-daniel.diaz@linaro.org>
 <20180208075148.gpxuve4cwwcp2etb@node.shutemov.name>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <a07c63af-adbf-142e-eaeb-079eb0ead9a3@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:28:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208075148.gpxuve4cwwcp2etb@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591810804203183380?=
X-GMAIL-MSGID: =?utf-8?q?1592322732302063435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/08/2018 12:51 AM, Kirill A. Shutemov wrote:
> On Wed, Feb 07, 2018 at 11:50:28PM -0600, Daniel Díaz wrote:
>> The 5lvl.c test file was incorporated into another one in
>> selftests/vm (va_128TBswitch.c) in commit 235266b8.
>>
>> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thanks. Applied to linux-kselftest fixes for 4.16-rc3.

thanks,
-- Shuah
