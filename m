Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELv3NFZdbmenxu9ra4RdfR77ucyqGAlapXDPCM8fZEoL/10F8+icpU6KfpP8mQp2hbfWn1/+
ARC-Seal: i=1; a=rsa-sha256; t=1520368135; cv=none;
        d=google.com; s=arc-20160816;
        b=BG0s+WO4CKgvuM1MC+7fP+Wtr5kGIaZVovu9Rkjz24ipgGYAvln193mNyWLOFqx26D
         B8Da3cF3XNUS1ZtsP/HrZiAuRsJIHH0xxt4eEDfNAMiAReje8bu2p1FNdw9+wSEcaK2P
         7K8KcLkYN6qgMP+z+w6XcEja5FHyJ65qZzJRM6POTD+fTeqx4hNxq7nxfFK0g+8l29q3
         IxqeGgCsxZ4MwgEKwRZG2glfLieBt4scbySt+n5AC/ubUUBPdKZtRry5ellXDm2yV/hq
         TCeDdAeY4SAiRahGur2qR+20N6qdB/FtYxck92lQtHvix6n2YvBnXYKiZZw5+nilQlZX
         Bjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=g0oxIlI2Q7f8pg4D29zWRCl8BVpFxGc96AzyoaJEzww=;
        b=Dv8X7R5MtnhlJL6jG8QuTrh1YdZik38K6TWtJRM6tpxqtX4tsK+8zP6J/NXxuHy2Ph
         FtSJfmiogd8hf17HPXA3OcwyjWdcDCqV32Y2EeOPBXkINzjPa2JyS5DTLHW/uS4tpeYu
         9L1StaSDld8/VFHqaDjG0w+nRXsbn7gLyRJt52rW/yF/WCc6zvvyKlr9YsVtPaRp0O7k
         /tzY1U3MqmHzGVoY0BuAKahyzk8LKzqqHeVHd6/01+7o0jrCg/Re8rXeJ7rEUom+xdAd
         dCp5Ny987U5X8H2pkRdBAm3nGRlHE/T4Tls4gu7YOFLCp9Gst+KHBNGKJbHjJDizejCO
         +QGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Z6hcnDM1;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Z6hcnDM1;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v2 6/8] [PATCH 6/8] Documentation: hwmon: Add a document
 for PECI hwmon client driver
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, joel@jms.id.au,
 andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 jdelvare@suse.com, linux@roeck-us.net, benh@kernel.crashing.org,
 andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e3750a0-d45b-368d-f5cb-d2cca6797ecb@infradead.org>
Date: Tue, 6 Mar 2018 12:28:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027890051239231?=
X-GMAIL-MSGID: =?utf-8?q?1594221538408945754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02/21/2018 08:16 AM, Jae Hyun Yoo wrote:

> +temp<n>_label		Provides DDR DIMM temperature if this label indicates
> +			'DIMM #'.
> +temp<n>_input		Provides current temperature of the DDR DIMM.
> +
> +Note:
> +	DIMM temperature group will be appeared when the client CPU's BIOS

	                       will appear when

> +	completes memory training and testing.
> 


-- 
~Randy
