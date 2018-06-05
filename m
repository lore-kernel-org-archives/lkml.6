Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeFEHEV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:04:21 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:54830 "EHLO
        12.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeFEHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:04:20 -0400
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
From: =?UTF-8?Q?S=c3=a9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sebastien.szymanski@armadeus.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwH8EEwECACkFAlNfZLECGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIX
 gAAKCRCwminogTJk4ss0CACpxtvYO1rCYNtc/j/6fkDsuKKwGtijixHU+C3N+EAJVoHSCdRM
 /PMtyN1fa+94XbW4LHQpZthkXd4kBpcf0aNtrS51193/YZHK5jLpJlUMKLGgU5VHXguakOOF
 ZWptlUCEqZaQ4gR8CUxPZi4urNAg/ORxCiVW2oMO/8GRhoZ+r14QNDGFVphbdlk/4YyY3wr7
 scDKTrRdkGw7kJElAp61I/B2KSbhnvF7U6H646a12/7bm6IEOAWbntoPcBg1h6irlCiNqfxs
 Zfy3r6rVRy840Dl7ldoUzOs7Eon8lUQilr9UorOHBF4NaBTpyD75DtvjRQsF2qV+R1RGS/Em
 IvrjzsBNBFNfZLEBCAC6O44V3Xa1wU0buUgI3pVed48hwSU1/7zeJy/1W21v7GnGvjSYw0sc
 eQwZqLWW0HViMmYkiI1P8Z00RL7Q65emXkrClne2aoromOH0kc8LkKfa3dMqkbsXrK1nsiQd
 cwknRLy8igEhEbfp8ZDgPiMyeMtai7b51q/ki9QF4EzMPk5MsCiAwkVh0yGGrNdZXRo/NoDi
 KWHl52qXjSx30+BEMINDXlmB8pycQEFol+Wj5cNLkqQEErAV0BSHt36aL3jEp1yvjxtgQTs3
 sWL+6+Eu9GurBfbIE0z6XyqlGqqgvrtfm1F+mpUwCoRiicsGhelYqi5YGPD38KIUsgJapU0T
 ABEBAAHCwGUEGAECAA8FAlNfZLECGwwFCQlmAYAACgkQsJop6IEyZOKWTgf/RbOvtKW77EXW
 XBzh04rfkW6prOlbJaIMUjVKZZ1D2OOpAxJbq80whJqCoJ+oVh7uAteozgX3U5TnL7fRx6HP
 zhyidiwKCOXEeTsFrRHEpTOCJYbPz8MTsK14ogz/aUlImt0HbxTaVHz5m65wWM8doCqOj2J9
 Vf12NNpfTxkotmM0QJQAIcEg10RfT3DLG1a68sdghM5rlz/b8mr/wjtOVxYX1TWKMvilCdQy
 YT8NNFcBwMEy5Jt2SXpeASY0CIXGwqqCBLqmQMhh3VcmibIbBBB0hIg4f56Vfn7v8ouFmbYS
 G0Q3TMIWXxYn91KiMXeox+Wsic2Ocw/KpZ/tus0JXQ==
To: Shawn Guo <shawnguo@kernel.org>
Message-ID: <717f24e1-3846-7685-b440-0754da883c2a@armadeus.com>
Date: Tue, 5 Jun 2018 09:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3747839316250743897
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrjedvgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 06:29 AM, Viresh Kumar wrote:
> On 22-05-18, 08:28, Sébastien Szymanski wrote:
>> Check the max speed supported from the fuses for i.MX6ULL and update the
>> operating points table accordingly.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>
>> Changes for v3:
>>  - none
> 
> @Sascha and Shawn: Can you guys please Ack this series if there is
> nothing wrong with it ?
> 

ping...

-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
