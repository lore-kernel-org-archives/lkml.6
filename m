Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvQwvAMHpuAG2MVdR2nHmXLxUFkECvxYQRs+D2VrwuzW4855ojaX9XIvxwiHK3K+r7FvDaF
ARC-Seal: i=1; a=rsa-sha256; t=1520876072; cv=none;
        d=google.com; s=arc-20160816;
        b=SfFSD/+Gr/UXCDRflkEJkLw2PJCenVjMDrXMSAlcfRnlTBfZ2AlSBitxvlZPCSAx6L
         7XDn6iHcV1nbxo1rvXEtDAaRijR3/HTUsBKaRwNpdsnoy/KJ/l2vp3BWUeZIJjEKZZMM
         GNRg8Rw+Of1pXBDc6e9HVFVl47nImQJfuaVpAVTP4+AfnjDtYpsZFyQCYi1oeXONFOYX
         +/YVm09HrpotiCu75vJOX3Oa15LFdby3vEuJiZkSmKIyRUZFSNax42oX2zgUt4VCOLsl
         h5jHwHK2XNsQAoRfwNGwdvVT3S92LwhKEUd/iysQJWsm0ptzugNoBZinSnhwMpaZ8G1/
         jrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=JRnMptceXGvHhb3dE8eXZE2TArAFrUY7rIBbPH+f6hc=;
        b=tG3LABfMLsyt7Ttze2p4v9ULUzLjNPhU1Cc8zHS97bOqXCnguchi5J/zPz5Tr86uP7
         SicMDT32j6kbPGmBWCnktM+tEAiIOad+BDe425a2E0KMsFEFsJ+srCdpKR9nrn004Ae0
         kEF9JNaScWvCfMHgcUOy/s6x3Uxeftlsnj9QZtoeeopWy5BuTk3RExAR9+Dpdi9Pcw7R
         HCmq1B1rjGcUidpuPcUqE05/NmxKqh/F7GrT2II6EpQk85rlapZWzDHI3VN79mSXYpOe
         JbxD1tbmgtekLzUhd+APs9NXDaUyWLPIw7tifa8ssYZtkAxVF+28Ih7YxVoKlQC1/+fO
         17lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeCLRec (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 12 Mar 2018 13:34:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:17864 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932274AbeCLReb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Mar 2018 13:34:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="36663525"
Subject: Re: kernel_selftests.x86.mpx-mini-test_32.fail on skylake platform
To: Li Zhijian <zhijianx.li@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <d36f0567-04a3-3e7f-4332-ce7518bfff60@intel.com>
Cc: "Li, Philip" <philip.li@intel.com>,
        Chen Rong <rongx.a.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <3aa057ec-c0e7-8b18-2054-ec2a6aecaeb9@linux.intel.com>
Date: Mon, 12 Mar 2018 10:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d36f0567-04a3-3e7f-4332-ce7518bfff60@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594421573984612479?=
X-GMAIL-MSGID: =?utf-8?q?1594754148739205462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 05:24 PM, Li Zhijian wrote:
> 0Day robot tried to bisect the FBC, but it failed at last. But anyway
> i want to let you know we had this issue.

Can you please bisect this, manually if necessary?  Let me know if you
need any help.
